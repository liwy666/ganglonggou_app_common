import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';

import '../common_import.dart';

class IndexAdSqflite extends BaseSqflite {
  static String _tableName = "gl_index_ad";
  static String _createTableSql = '''
    create table $_tableName (
  id mediumint(8) primary key not null,
  into_type varchar(100),
  click_count int(10),
  position_type varchar(100),
  is_on_sale int(1),
  position_type2 varchar(100),
  position_type_name varchar(255),
  father_position_name varchar(100),
  sort_order smallint(5),
  ad_type varchar(100),
  ad_img text(0),
  goods_id mediumint(8),
  cat_id mediumint(8),
  url text(0),
  text text(0),
  goods_name varchar(255),
  goods_price varchar(10),
  origin_goods_price varchar(10))''';

  IndexAdSqflite()
      : super(tableName: _tableName, createTableSql: _createTableSql);

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
    //清空表
    await super.open();
    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as IndexAdItem).toJson();
      BaseSqflite.db.insert(_tableName, itemMap);
    });
    //修改失效时间
    BaseSqflite.db.update(
        CONFIG_TABLE_NAME,
        {
          "config_value": (DateTime.now().millisecondsSinceEpoch +
              COMMON_SQL_DATA_INVALID_TIME)
        },
        where: 'config_key=\'index_info_invalid_time\'');
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
}
