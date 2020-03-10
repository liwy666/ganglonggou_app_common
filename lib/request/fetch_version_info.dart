import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/get_app_version';

class FetchVersionInfo {
  static Future<GetVersionInfo> fetch() async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'platform': SON_INTO_TYPE});
    final Map<String, dynamic> data = response.data;
    return GetVersionInfo.fromJson(data);
  }
}
