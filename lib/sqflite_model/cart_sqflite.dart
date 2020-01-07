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
  Future insertData(Map<String, dynamic> mapDate) async {
    // TODO: implement insertData
    await BaseSqflite.db.insert(_tableName, mapDate);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    // TODO: implement queryAll
    List<Map<String, dynamic>> list = await BaseSqflite.db.query(_tableName);
    return list;
  }

  ///更新购物车数量
  Future updateCartNumber(
      {@required int cartId,
      @required int cartNumber,
      @required double cartPrice}) async {
    await BaseSqflite.db.execute(
        "UPDATE $_tableName SET goodsNumber = $cartNumber, goodsPrice = $cartPrice WHERE cartId = $cartId");
  }

  ///切换购物车选中状态
  Future switchCartChoiceState(
      {@required int cartId, @required int isChoice}) async {
    await BaseSqflite.db.execute(
        "UPDATE $_tableName SET isChoice = $isChoice WHERE cartId = $cartId");
  }

  ///删除购物车
  Future delCart(
      {@required int cartId}) async {
    await BaseSqflite.db.execute(
        "DELETE FROM $_tableName WHERE cartId = $cartId");
  }

  ///获取用户所有购物车
  Future<List<Map<String, dynamic>>> queryUserAllCart(
      {@required int userId}) async {
    // TODO: implement queryAll
    List<Map<String, dynamic>> list =
        await BaseSqflite.db.query(_tableName, where: "userId = $userId");
    return list;
  }
}
