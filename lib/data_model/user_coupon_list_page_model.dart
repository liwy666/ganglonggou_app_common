import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/couponItem.dart';
import 'package:ganglong_shop_app/models/couponList.dart';
import 'package:ganglong_shop_app/request/fetch_user_have_coupon_list.dart';

class UserCouponListPageModel with ChangeNotifier {
  List<CouponItem> _couponItemList = [];

  List<CouponItem> get couponItemList => _couponItemList;

  Future<void> init(String userToken) async {
    CouponList couponList =
        await FetchUserHaveCouponList.fetch(userToken: userToken);
    _couponItemList = couponList.data;
    print(_couponItemList.length);
    notifyListeners();
  }
}
