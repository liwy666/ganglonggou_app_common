import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_all_coupon_list';

class FetchCouponList {
  static Future<CouponList> fetch({@required String intoType}) async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'into_type': intoType});
    final Map<String, dynamic> data = {"data": response.data};
    return CouponList.fromJson(data);
  }
}
