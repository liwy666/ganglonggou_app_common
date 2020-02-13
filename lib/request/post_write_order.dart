import 'package:crypto/crypto.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

const String FETCH_INDEX_INFO_URL = "/user_submit_order";

class PostWriteOrder {
  static Future<String> post(Map<String, dynamic> submitInfo) async {
    final response =
        await dio.post(FETCH_INDEX_INFO_URL, queryParameters: submitInfo);
    return response.data;
  }
}
