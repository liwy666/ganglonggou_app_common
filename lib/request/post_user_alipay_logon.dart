import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

const String FETCH_INDEX_INFO_URL = "/android_ali_pay_login";

class PostUserAliPayLogon {
  static Future<String> post({@required String code}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "code": code,
    });
    final String result = response.data;

    return result;
  }
}
