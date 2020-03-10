import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

const FETCH_INDEX_INFO_URL = '/user_get_coupon_list';

class FetchUserHaveCouponList {
  static Future<CouponList> fetch({@required String userToken}) async {
    final response = await dio
        .get(FETCH_INDEX_INFO_URL, queryParameters: {'user_token': userToken});
    final Map<String, dynamic> data = {"data": response.data};
    return CouponList.fromJson(data);
  }
}
