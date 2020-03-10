import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_one_order_info';

class FetchOrderInfo {
  static Future<OrderInfo> fetch(
      {@required String userToken, @required String orderSn}) async {
    final response = await dio.get(FETCH_INDEX_INFO_URL,
        queryParameters: {'user_token': userToken, 'order_sn': orderSn});
    final Map<String, dynamic> data = response.data;
    return OrderInfo.fromJson(data);
  }
}
