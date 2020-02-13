import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

const String FETCH_INDEX_INFO_URL = "/android_user_login";

class PostUserLogon {
  static Future<String> post(
      {@required String emailAddress, @required String password}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "email_address": emailAddress,
      "password": md5.convert(utf8.encode(password))
    });
    final String result = response.data;

    return result;
  }
}
