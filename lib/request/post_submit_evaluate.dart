import 'package:crypto/crypto.dart';
import 'package:flutter_app/common_import.dart';
import 'dart:convert';

import 'package:flutter_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_ins_evaluate";

class PostSubmitEvaluate {
  static Future<bool> post(
      {@required String userToken,
      @required int midOrderId,
      @required String evaluateText,
      @required double rate}) async {
    final response = await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "user_token": userToken,
      "evaluate_text": evaluateText,
      "rate": rate,
      "id": midOrderId,
    });
    return true;
  }
}
