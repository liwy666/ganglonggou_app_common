import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_classify_ad_list';

class FetchClassifyList {
  static Future<ClassifyList> fetch() async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'into_type': INTO_TYPE});
    final Map<String, dynamic> data = {"data": response.data};
    return ClassifyList.fromJson(data);
  }
}
