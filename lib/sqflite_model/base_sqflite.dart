import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/sqflite_model/sqlfite_config.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseSqflite {
  static Database db;
  static List<Map<String, String>> _initConfigTableSqlCode = [
    {"config_key": "index_info_invalid_time", "config_value": "0"},
    {"config_key": "classify_list_invalid_time", "config_value": "0"},
    {"config_key": "theme_mode", "config_value": "default"},
  ];

  /*初始化sql*/
  static Future initSql() async {
    String appPath = (await getApplicationDocumentsDirectory()).path;
    String sqlDbPath = appPath + "/$SQL_FILE_NAME";

    if (SQL_DEBUG) {
      await deleteDatabase(sqlDbPath);
    }
    if (db == null) {
      db = await openDatabase(sqlDbPath, version: SQL_VERSION,
          onCreate: (Database db, int version) async {
        await _onCreate(db, version);
      }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await _onUpgrade(db, oldVersion, newVersion, sqlDbPath);
      });
    }
  }

  /*关闭*/
  static Future close() async {
    var dbClient = db;
    return await dbClient.close();
  }

  /*插入单条数据*/
  Future insertData(Map<String, dynamic> mapDate);

  /*插入全部数据*/
  Future insertAllDate<T>(List<T> mapAllDate);

  /*返回全部数据*/
  Future<List<Map<String, dynamic>>> queryAll();

  ///onUpgrade 如果满足以下任一条件，则调用：
  ///onCreate 未指定
  ///该数据库已存在，version并且高于上一个数据库版本
  ///在onCreate未指定的第一种情况下，onUpgrade其oldVersion参数称为0。在第二种情况下，您可以执行必要的迁移过程来处理不同的架构
  static Future<void> _onUpgrade(
      Database db, int oldVersion, int newVersion, String sqlDbPath) async {
    print("执行：_onUpgrade更新数据库，旧版本：$oldVersion,新版本：$newVersion");
    //删除所有表
    SQL_TABLE_NAME_LIST.forEach((String tableName) async {
      await db.execute("DROP TABLE $tableName");
    });
    //重新创建数据库
    await _onCreate(db, newVersion);
  }

  ///如果在调用openDatabase之前数据库不存在，则调用 。您可以借此机会根据您的模式在数据库中创建所需的表
  static Future<void> _onCreate(Database db, int version) async {
    print("执行：_onCreate创建数据库");
    //1.创建数据表
    CREATE_SQL_CODE_LIST.forEach((String code) async {
      await db.execute(code);
    });
    //2.插入配置表数据
    _initConfigTableSqlCode.forEach((Map<String, String> mapItem) {
      db.insert(CONFIG_TABLE_NAME, mapItem);
    });
  }
}
