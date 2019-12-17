import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';
import 'package:flutter_app/sqflite_model/sqlfite_config.dart';

class CartSqFlite extends BaseSqflite {
  static String _tableName = CART_TABLE_NAME;

  @override
  Future insertAllDate<T>(List<T> mapAllDate) async {
    // TODO: implement insertAllDate
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
//    await BaseSqflite.db.execute("DELETE FROM $_tableName");
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }
}
