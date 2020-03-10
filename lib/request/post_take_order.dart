import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

import 'package:ganglong_shop_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_take_order";

class PostTakeOrder {
  static Future<bool> post(
      {@required String userToken, @required String orderSn}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "order_sn": orderSn,
    });
    return true;
  }
}
