import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_submit_after_sale";

class PostSubmitAfterService {
  static Future<bool> post(
      {@required String userToken,
      @required String orderSn,
      @required String choiceServiceType,
      @required String choiceServiceReason,
      @required String serviceDescribe}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "order_sn": orderSn,
      "after_sale_type": choiceServiceType,
      "after_sale_cause": choiceServiceReason,
      "after_sale_text": serviceDescribe,
    });
    return true;
  }
}
