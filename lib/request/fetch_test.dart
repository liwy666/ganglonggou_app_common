import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/test';

class FetchTest {
  static Future<bool> fetch() async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL);
    return response.data;
  }
}
