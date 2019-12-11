import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';

class CartSqFlite extends BaseSqflite {
  static String _tableName = "gl_cart";
  static String _createTableSql = '''
  create table $_tableName (
  id INTEGER primary key AUTOINCREMENT not null,
  goodsNumber int(10),
  goodsSn varchar(60),
  goodsName varchar(120),
  goodsId mediumint(8),
  catId mediumint(8),
  goodsHeadName varchar(120),
  goodsPrice decimal(12),
  oneGoodsPrice decimal(12),
  marketPrice decimal(12),
  goodsStock int(10),
  goodsSalesVolume int(10),
  goodsAttributeImg text(0),
  skuId mediumint(8),
  attrDesc varchar(255),
  isPromote int(1),
  promoteNumber int(10),
  promoteStartDate int(10),
  promoteEndDate int(10),
  giveIntegral int(10),
  integral int(10),
  oneGiveIntegral int(10),
  oneIntegral int(10),
  integralDesc text(0),
  byStagesNumber int(5),
  isValid int(1),
  isChoice int(1))''';

  CartSqFlite() : super(tableName: _tableName, createTableSql: _createTableSql);

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
    await super.open();
    //清空表
    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    mapAllDate.forEach((T item) async {
      Map<String, dynamic> itemMap = (item as CartItem).toJson();
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
//    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }
}
