import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/payment/user_order_payment';

class FetchWeChatPrepayInfo {
  static Future<WeChatPrepayInfo> fetch(
      {@required String userToken, @required String orderSn}) async {
    final response = await dio.get(FETCH_INDEX_INFO_URL,
        queryParameters: {'user_token': userToken, 'order_sn': orderSn});
    final Map<String, dynamic> data = response.data;
    return WeChatPrepayInfo.fromJson(data);
  }
}
