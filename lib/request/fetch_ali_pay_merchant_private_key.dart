import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/get_ali_pay_merchant_private_key';

class FetchAliPayMerchantPrivateKey {
  static Future<String> fetch() async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'into_type': INTO_TYPE});
    return response.data;
  }
}
