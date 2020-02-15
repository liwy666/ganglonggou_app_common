import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return MySingleRowTile(
          child: Text("地址管理"),
          rightIcon: Icon(
            Icons.edit_location,
            color: Theme.of(context).accentColor,
          ),
          onTapFunction: () {
            if (!userInfoModel.isLogon) {
              Application.router.navigateTo(context, "/logon?showBar=true");
              return;
            }
            Application.router.navigateTo(context, '/address_list');
          },
          marginTop: ScreenUtil().setWidth(50),
        );
      },
    );
  }
}
