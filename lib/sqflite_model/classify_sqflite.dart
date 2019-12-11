import 'dart:convert';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';

import '../common_import.dart';

class ClassifySqflite extends BaseSqflite {
  static String _tableName = "gl_classify";
  static String _createTableSql = '''
    create table $_tableName (
  id mediumint(8) primary key not null,
  classify_name varchar(90),
  into_type varchar(20),
  click_type varchar(20),
  parent_id mediumint(8),
  sort_order smallint(5),
  key_word varchar(10),
  goods_id mediumint(8),
  logo_img text(0),
  bar_img text(0))''';

  ClassifySqflite()
      : super(tableName: _tableName, createTableSql: _createTableSql);

  @override
  insertData(Map<String, dynamic> mapDate) async {
    // TODO: implement insertData
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    // TODO: implement queryAll
    await super.open();
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
    await super.open();
    //清空表
    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as Map);
      BaseSqflite.db.insert(_tableName, itemMap);
    });
    //修改失效时间
    BaseSqflite.db.update(
        CONFIG_TABLE_NAME,
        {
          "config_value": (DateTime.now().millisecondsSinceEpoch +
              COMMON_SQL_DATA_INVALID_TIME)
        },
        where: 'config_key=\'classify_list_invalid_time\'');
  }
}
