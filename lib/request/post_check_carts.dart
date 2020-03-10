import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/cartItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_get_cart";

class PostCheckCarts {
  static Future<List<Map<String, dynamic>>> post(
      {@required List<CartItem> cartItemList}) async {
    //对数据进行整理
    Map<String, dynamic> queryData = {};
    for (int i = 0; i < cartItemList.length; i++) {
      queryData["carts[$i][sku_id]"] = cartItemList[i].skuId;
      queryData["carts[$i][goods_id]"] = cartItemList[i].goodsId;
      queryData["carts[$i][goods_number]"] = cartItemList[i].goodsNumber;
    }

    final response =
        await dio.post(FETCH_INDEX_INFO_URL, queryParameters: queryData);
    final List<dynamic> data = response.data;
    final List<Map<String, dynamic>> result = [];
    data.forEach((dynamic item) {
      Map<String, dynamic> _map = {};
      if (item["cart_is"]) {
        _map["isValid"] = item["cart_is"] ? 1 : 0;
        _map["goodsId"] = (item["goods_id"] is int)
            ? item["goods_id"]
            : int.parse(item["goods_id"]);
        _map["skuId"] = (item["sku_id"] is int)
            ? item["sku_id"]
            : int.parse(item["sku_id"]);
        _map["goodsName"] = item["goods_name"];
        _map["goodsHeadName"] = item["goods_head_name"];
        _map["goodsNumber"] = (item["goods_number"] is int)
            ? item["goods_number"]
            : int.parse(item["goods_number"]);
        _map["goodsStock"] = (item["goods_stock"] is int)
            ? item["goods_stock"]
            : int.parse(item["goods_stock"]);
        _map["attrDesc"] = item["attr_desc"];
        _map["oneGiveIntegral"] = (item["one_give_integral"] is int)
            ? item["one_give_integral"]
            : int.parse(item["one_give_integral"]);
        _map["oneIntegral"] = (item["one_integral"] is int)
            ? item["one_integral"]
            : int.parse(item["one_integral"]);
        _map["oneGoodsPrice"] = (item["one_goods_price"] is double)
            ? item["one_goods_price"]
            : double.parse(item["one_goods_price"]);
        _map["goodsPrice"] = (item["goods_price"] is double)
            ? item["goods_price"]
            : double.parse(item["goods_price"]);
        _map["giveIntegral"] = (item["give_integral"] is int)
            ? item["give_integral"]
            : int.parse(item["give_integral"]);
        _map["integral"] = (item["integral"] is int)
            ? item["integral"]
            : int.parse(item["integral"]);
      } else {
        _map["isValid"] = 0;
        _map["goodsId"] = (item["goods_id"] is int)
            ? item["goods_id"]
            : int.parse(item["goods_id"]);
        _map["skuId"] = (item["sku_id"] is int)
            ? item["sku_id"]
            : int.parse(item["sku_id"]);
      }
      result.add(_map);
    });
    return result;
  }
}
