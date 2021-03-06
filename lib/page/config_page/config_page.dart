import 'dart:convert';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_single_row_tile.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/page/components/update_app/update_app.dart';
import 'package:flutter_app/request/fetch_version_info.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ConfigPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: MyTabBar(
        tabBarName: "设置中心",
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 25),
            child: Column(
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: MyExtendedImage.asset('static_images/logo_320.png',
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
                    "v$VERSION",
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            onTapFunction: () {},
            child: Text("关于我们"),
          ),
          MySingleRowTile(
            onTapFunction: () {
              Application.router.navigateTo(context,
                  '/web_view?initialLink=${base64UrlEncode(utf8.encode(PRIVACY_AGREEMENT_URL))}');
            },
            child: Text("隐私协议查看"),
          ),
          MySingleRowTile(
            onTapFunction: () {
              Application.router.navigateTo(context,
                  '/web_view?initialLink=${base64UrlEncode(utf8.encode(USER_AGREEMENT_URL))}');
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
              if (_getVersionInfo.result_code == "success" &&
                  _getVersionInfo.app_version != VERSION) {
                UpdateApp(context: context, getVersionInfo: _getVersionInfo);
              } else {
                Fluttertoast.showToast(msg: "您的应用为最新版本"); //短提示
              }
            },
            child: Text("检查更新"),
          ),
          MySingleRowTile(
            onTapFunction: () {},
            child: Text("反馈"),
          ),
        ],
      ),
    );
  }
}
