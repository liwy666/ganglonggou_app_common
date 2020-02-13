import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/order_data_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_config.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_coupon.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_order.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_quit_logon_button.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_to_start_page.dart';
import 'package:ganglong_shop_app/page/home_page/companents/home_user_info_preview.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

import 'companents/home_address.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return userInfoModel.isLogon ? _HomePage() : _NotLogonHomePage();
      },
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer2<UserInfoModel, OrderDataModel>(
      child: ListView(
        children: <Widget>[
          HomeUserInfoPreview(),
          HomeOrder(),
          HomeAddress(),
          HomeCoupon(),
          HomeConfig(),
          HomeQuitLogonButton(),
        ],
      ),
      builder: (BuildContext context, UserInfoModel userInfoModel,
          OrderDataModel orderDataModel, Widget child) {
        //初始化orderModel
        orderDataModel.init(userInfoModel.userInfo.user_token);
        return Scaffold(
          backgroundColor: _themeModel.pageBackgroundColor1,
          appBar: MyTabBar(
            tabBarName: '个人中心',
            hideLeftButton: true,
            backgroundColor: Theme.of(context).accentColor,
            tabBarNameColor: Colors.white,
          ),
          body: RefreshIndicator(
            child: child,
            onRefresh: () async {
              await userInfoModel.reFreshUserInfo();
              await orderDataModel.reFresh(userInfoModel.userInfo.user_token);
            },
          ),
        );
      },
    );
  }
}

class _NotLogonHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      body: Center(
        child: RaisedButton(
          child: Text(
            "马上登录",
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
          shape: StadiumBorder(
              side: new BorderSide(
            style: BorderStyle.none,
          )),
          //color: Colors.red,
          onPressed: () {
            Application.router.navigateTo(context, '/logon');
          },
        ),
      ),
    );
  }
}
