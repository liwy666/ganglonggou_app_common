import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

import 'package:ganglong_shop_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/send_retrieve_password_or_login_email_verify_code";

class PostSendRetrievePasswordOrLoginEmailVerifyCode {
  static Future<bool> post({@required String emailAddress}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "email_address": emailAddress,
    });

    return response.data;
  }
}
