import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_add_address";

class PostAddAddress {
  static Future<bool> post(
      {@required String userToken, @required AddressItem addressItem}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "name": addressItem.name,
      "tel": addressItem.tel,
      "province": addressItem.province,
      "city": addressItem.city,
      "county": addressItem.county,
      "address_detail": addressItem.address_detail,
      "area_code": addressItem.area_code,
    });
    return true;
  }
}
