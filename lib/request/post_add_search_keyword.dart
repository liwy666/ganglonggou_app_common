import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'dart:convert';

import 'package:ganglong_shop_app/models/addressItem.dart';

const String FETCH_INDEX_INFO_URL = "/user_add_search_log";

class PostAddSearchKeyword {
  static Future<bool> post({@required String searchKeyword}) async {
    final Response response =
        await dio.post(FETCH_INDEX_INFO_URL, queryParameters: {
      "search_keyword": searchKeyword,
      "into_type": INTO_TYPE,
      "son_into_type": SON_INTO_TYPE,
    });
    return true;
  }
}
