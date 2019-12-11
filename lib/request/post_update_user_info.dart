import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_upd_info";

class PostUpdateUserInfo {
  static Future<bool> post(
      {@required String userToken,
      @required String userName,
      @required String userImg}) async {
    final Response response =
        await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "user_name": userName,
      "user_img": userImg,
    });
    return true;
  }
}
