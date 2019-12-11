import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_search_log';

class FetchSearchLog {
  static Future<SearchKeywordList> fetch() async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'into_type': INTO_TYPE});
    final List<dynamic>  data = response.data;
    return SearchKeywordList.fromJson({"data": data});
  }
}
