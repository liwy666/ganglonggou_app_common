import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/start_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/getVersionInfo.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/page/components/update_app/update_app.dart';
import 'package:ganglong_shop_app/page/test_page/components/test_verify_component.dart';
import 'package:ganglong_shop_app/request/fetch_version_info.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_appstore/open_appstore.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_web_view/flutter_web_view.dart';

class ConfigPage extends StatelessWidget {
  final FlutterWebView flutterWebView = new FlutterWebView();

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: MyTabBar(
        tabBarName: "设置中心",
      ),
      body: Consumer<StartModel>(
        builder: (BuildContext context, StartModel startModel, _) {
          return ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 25),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MyExtendedImage.asset(
                            'static_images/logo_320.png',
                            width: ScreenUtil().setWidth(180),
                            height: ScreenUtil().setWidth(180)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        APP_NAME,
                        style: TextStyle(
                          color: _themeModel.fontColor1,
                          fontSize: SO_LARGE_FONT_SIZE,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        "v${startModel.appVersion}",
                        style: TextStyle(
                          color: Color(0xffb2bec3),
                          fontSize: COMMON_FONT_SIZE,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: _themeModel.pageBackgroundColor2,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "跟随系统",
                      style: TextStyle(color: _themeModel.fontColor1),
                    ),
                    Switch(
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        if (value) {
                          _themeModel.onFollowingSystem();
                        } else {
                          _themeModel.offFollowingSystem();
                        }
                      },
                      value: _themeModel.appThemeModeFollowingSystem,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: _themeModel.pageBackgroundColor2,
                  child: Text(
                    "如果您想手动选择是否开启'夜间模式'，可以关掉此开关",
                    style: TextStyle(
                        fontSize: SMALL_FONT_SIZE,
                        color: _themeModel.fontColor2),
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                color: _themeModel.pageBackgroundColor2,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "夜间模式",
                      style: TextStyle(color: _themeModel.fontColor1),
                    ),
                    Switch(
                      activeColor: Colors.blue,
                      onChanged: (bool value) {
                        if (_themeModel.appThemeModeFollowingSystem) return;
                        if (value) {
                          _themeModel.switchNightMode();
                        } else {
                          _themeModel.switchDefaultMode();
                        }
                      },
                      value: _themeModel.appThemeMode == AppThemeMode.nightMode,
                    ),
                  ],
                ),
              ),
              MySingleRowTile(
                onTapFunction: () {
                  Application.router.navigateTo(context,
                      '/web_view?initialLink=${base64UrlEncode(utf8.encode(ABOUT_WE_URL))}');
                },
                child: Text("关于我们"),
              ),
              MySingleRowTile(
                onTapFunction: () {
                  openPrivacyAgreement(context);
                },
                child: Text("隐私协议查看"),
              ),
              MySingleRowTile(
                onTapFunction: () {
                  openUserAgreement(context);
                },
                child: Text("用户协议查看"),
              ),
              MySingleRowTile(
                onTapFunction: () async {
                  MyLoading.eject();
                  GetVersionInfo _getVersionInfo;
                  try {
                    _getVersionInfo = await FetchVersionInfo.fetch();
                  } catch (e) {
                    print(e);
                  } finally {
                    MyLoading.shut();
                  }
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  int buildNumber = int.parse(packageInfo.buildNumber);
                  if (_getVersionInfo.result_code == "success" &&
                      _getVersionInfo.build_number > buildNumber) {
                    UpdateApp(
                        context: context, getVersionInfo: _getVersionInfo);
                  } else {
                    MyToast.showToast(msg: "您的应用为最新版本"); //短提示
                  }
                },
                child: Text("检查更新"),
              ),
              MySingleRowTile(
                onTapFunction: () async {
                  await launch(
                      "$FEED_BACK_URL?version=${startModel.appVersion}&platform=$SON_INTO_TYPE");
                },
                child: Text("反馈"),
              ),
              MySingleRowTile(
                onTapFunction: () async {
                  //Application.router.navigateTo(context, '/test');
                  MyDialog().showBottomDialog(
                      context: context, child: TestVerifyComponent());
                  /**
                   * iosDialog
                      showCupertinoDialog<int>(
                      context: context,
                      builder: (context) {
                      return CupertinoAlertDialog(
                      title: Text("Alert"),
                      content: TextField(),
                      actions: <Widget>[
                      CupertinoDialogAction(
                      child: Text("Sure"),
                      onPressed: () {
                      Navigator.pop(context, 1);
                      },
                      ),
                      CupertinoDialogAction(
                      child: Text("Cancel"),
                      onPressed: () {
                      Navigator.pop(context, 2);
                      },
                      )
                      ],
                      );
                      });*/
                },
                child: Text("岗隆实验室"),
              ),
            ],
          );
        },
      ),
    );
  }
}
