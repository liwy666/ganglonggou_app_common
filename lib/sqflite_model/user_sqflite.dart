import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';

class UserSqflite extends BaseSqflite {
  static String _tableName = "gl_user";
  static String _createTableSql = '''
  create table $_tableName (
  id INTEGER primary key AUTOINCREMENT not null,
  user_id int(10),
  user_token int(10),
  user_name varchar(32),
  user_img text(0),
  add_time int(10),
  name varchar(32),
  email varchar(60),
  phone varchar(20),
  integral int(10))''';

  UserSqflite() : super(tableName: _tableName, createTableSql: _createTableSql);

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
    await super.open();
    //清空表
    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as UserInfo).toJson();
      BaseSqflite.db.insert(_tableName, itemMap);
    });
  }

  @override
  Future insertData(Map<String, dynamic> mapDate) {
    // TODO: implement insertData
    return null;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    // TODO: implement queryAll
    await super.open();
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }

  /*清空表*/
  Future emptyTable() async {
    await super.open();

    await BaseSqflite.db.execute("DELETE FROM $_tableName");
  }
}
