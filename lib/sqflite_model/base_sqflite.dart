import 'package:flutter_app/common_import.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseSqflite {
  final String tableName;
  final String createTableSql;
  static Database db;
  static List<Map<String, String>> intConfigTableSqlCode = [
    {"config_key": "index_info_invalid_time", "config_value": "0"},
    {"config_key": "classify_list_invalid_time", "config_value": "0"},
  ];

  BaseSqflite({@required this.tableName, @required this.createTableSql}) {
    if (tableName == null) {
      throw new FormatException('你需要在子类构造函数中实现super方法');
    }
  }

  /*初始化sql*/
  static Future initSql() async {
    String appPath = (await getApplicationDocumentsDirectory()).path;
    String sqlDbPath = appPath + "/$SQL_FILE_NAME";
    if (db == null) {
      db = await openDatabase(sqlDbPath, version: SQL_VERSION);
    }
    //初始化配置表
    //删除表
    //db.execute("DROP TABLE $CONFIG_TABLE_NAME");
    //检测表是否存在
    int tableCount = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM sqlite_master WHERE type = \'table\' AND name = \'$CONFIG_TABLE_NAME\''));
    //创建表
    if (tableCount == 0) {
      await db.execute(CREATE_CONFIG_TABLE_SQL_CODE);
      //执行初始化数据语句
      intConfigTableSqlCode.forEach((Map<String, String> mapItem) {
        db.insert(CONFIG_TABLE_NAME, mapItem);
      });
    }
  }

  Future open() async {
    String appPath = (await getApplicationDocumentsDirectory()).path;
    String sqlDbPath = appPath + "/$SQL_FILE_NAME";
    if (db == null) {
      db = await openDatabase(sqlDbPath, version: SQL_VERSION);
    }
    //删除表
    //db.execute("DROP TABLE $tableName");
    //检测表是否存在
    int tableCount = Sqflite.firstIntValue(await db.rawQuery(
        'SELECT COUNT(*) FROM sqlite_master WHERE type = \'table\' AND name = \'$tableName\''));
    //创建表
    if (tableCount == 0) {
      await db.execute(createTableSql);
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
}
