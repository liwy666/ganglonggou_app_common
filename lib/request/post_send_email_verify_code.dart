import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/send_register_email_verify_code";

class PostSendEmailVerifyCode {
  static Future<bool> post({@required String emailAddress}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "email_address": emailAddress,
    });

    return response.data;
  }
}
