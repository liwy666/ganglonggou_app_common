import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_upd_default_address";

class PostSwitchDefaultAddress {
  static Future<bool> post(
      {@required String userToken, @required int addressId}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "address_id": addressId,
    });
    return true;
  }
}
