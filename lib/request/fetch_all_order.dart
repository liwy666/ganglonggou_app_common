import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_all_order';

class FetchAllOrder {
  static Future<OrderPreviewInfo> fetch({@required String userToken}) async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'user_token': userToken});
    final Map<String, dynamic> data = {"data": response.data};
    return OrderPreviewInfo.fromJson(data);
  }
}
