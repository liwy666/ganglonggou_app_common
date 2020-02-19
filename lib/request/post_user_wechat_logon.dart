import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

const String FETCH_INDEX_INFO_URL =
    SON_INTO_TYPE == 'ios' ? "ios_wx_login" : "/android_wx_login";

class PostUserWeChatLogon {
  static Future<String> post({@required String code}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "code": code,
    });
    final String result = response.data;

    return result;
  }
}
