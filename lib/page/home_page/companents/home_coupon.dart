import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

class HomeCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context,UserInfoModel userInfoModel,_){
        return  MySingleRowTile(
          child: Text("我的优惠券"),
          rightIcon: Icon(
            Icons.confirmation_number,
            color: Theme.of(context).accentColor,
          ),
          onTapFunction: () {
            if (!userInfoModel.isLogon) {
              Application.router.navigateTo(context, "/logon?showBar=true");
              return;
            }
            Application.router.navigateTo(context, '/user_coupon_list');
          },
        );
      },
    );
  }
}
