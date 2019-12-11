import 'dart:convert';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';

class GoodsSqflite extends BaseSqflite {
  static String _tableName = "gl_goods";
  static String _createTableSql = '''
    create table $_tableName (
  goods_id mediumint(8) primary key not null,
  cat_id integer(8),
  goods_sn varchar(60),
  goods_name varchar(120),
  goods_head_name varchar(255),
  market_price varchar(10),
  shop_price varchar(10),
  keywords varchar(255),
  goods_brief varchar(255),
  goods_desc text(0),
  goods_stock smallint(5),
  goods_img text(0),
  original_img text(0),
  sort_order smallint(4),
  goods_sales_volume int(10),
  evaluate_count int(10),
  attribute text(0),
  is_promote tinyint(1),
  promote_number smallint(5),
  promote_start_date int(11),
  promote_end_date int(11),
  supplier_id mediumint(8),
  supplier_name varchar(30),
  add_time int(10),
  cat_name varchar(90))''';

  GoodsSqflite()
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
    //插入数据
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as GoodsItem).toJson();
      itemMap["attribute"] =
          json.encode((item as GoodsItem).attribute.map((GoodsAttribute attr) {
        return attr.toJson();
      }).toList());
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
}
