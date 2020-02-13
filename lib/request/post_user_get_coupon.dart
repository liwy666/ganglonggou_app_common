import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

import 'package:ganglong_shop_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_get_coupon";

class PostUserGetCoupon {
  static Future<String> post(
      {@required String userToken, @required int couponId}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "coupon_id": couponId,
    });
    return response.data;
  }
}
