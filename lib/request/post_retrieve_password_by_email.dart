import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/retrieve_password_by_email_verify_code";

class PostRetrievePasswordByEmail{
  static Future<String> post(
      {@required String emailAddress,
      @required String password,
      @required String verifyCode}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "email_address": emailAddress,
      "password": password,
      "verify_code": verifyCode,
      "into_type": INTO_TYPE,
      "son_into_type": SON_INTO_TYPE,
    });

    return response.data;
  }
}
