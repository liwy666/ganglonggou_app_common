import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/couponItem.dart';
import 'package:ganglong_shop_app/models/couponList.dart';
import 'package:ganglong_shop_app/request/fetch_coupon_list.dart';
import 'package:ganglong_shop_app/request/post_user_get_coupon.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CouponListPageModel with ChangeNotifier {
  final UserInfoModel userInfoModel;
  final BuildContext pageContext;
  List<CouponItem> _couponList = [];

  List<CouponItem> get couponList => _couponList;

  CouponListPageModel(
      {@required this.userInfoModel, @required this.pageContext});

  Future<void> init() async {
    CouponList _couponListTemp =
        await FetchCouponList.fetch(intoType: INTO_TYPE);
    _couponList = _couponListTemp.data;
    print(_couponList.length);
    notifyListeners();
  }

  Future<void> userGetCoupon(int couponId) async {
    if (!userInfoModel.isLogon) {
      Application.router.navigateTo(pageContext, "/logon?showBar=true");
      return;
    }
    String result = await PostUserGetCoupon.post(
        userToken: userInfoModel.userInfo.user_token, couponId: couponId);
    Fluttertoast.showToast(msg: result);
  }
}
