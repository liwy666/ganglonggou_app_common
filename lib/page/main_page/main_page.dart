import 'dart:async';
import 'dart:convert';

import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/data_model/main_page_model.dart';
import 'package:ganglong_shop_app/data_model/start_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/page/carts_page/carts_page.dart';
import 'package:ganglong_shop_app/page/classify_page/classify_page.dart';
import 'package:ganglong_shop_app/page/components/ask_whether_agree_agreement/ask_whether_agree_agreement.dart';
import 'package:ganglong_shop_app/page/components/global_back_button.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/page/components/update_app/update_app.dart';
import 'package:ganglong_shop_app/page/first_page/first_page.dart';
import 'package:ganglong_shop_app/page/home_page/home_page.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  final int currentIndex;
  final bool needUpdateApp;
  final bool whetherInitialInstallation;

  const MainPage(
      {Key key,
      @required this.currentIndex,
      this.needUpdateApp,
      this.whetherInitialInstallation})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> {
  int _currentIndex = 0;
  StartModel _startModel;

  @override
  void initState() {
    if (DEBUG) {
      GlobalBackButton.show(context);
    }
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      //检查是否需要更新
      if (widget.needUpdateApp) {
        UpdateApp(context: context, getVersionInfo: _startModel.getVersionInfo);
      }
      //检查是否是第一次安装
      if (widget.whetherInitialInstallation) {
        final _configModel = Provider.of<ConfigModel>(context);
        _configModel.alreadyInstallation();
        AskWhetherAgreeAgreement(context: context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    _startModel = Provider.of<StartModel>(context);
    _currentIndex = widget.currentIndex;
    // TODO: implement build
    return ProviderWidget<MainPageModel>(
      model: MainPageModel(currentIndex: _currentIndex),
      child: Consumer<ClassifyListDataModel>(
        builder: (BuildContext context,
            ClassifyListDataModel classifyListDataModel, _) {
          return FirstPage(
            key: PageStorageKey<String>("主页"),
            classifyListLength: classifyListDataModel.classifyListLength,
            firstPageClassifyPage: classifyListDataModel.firstPageClassifyPage,
          );
        },
      ),
      builder:
          ((BuildContext context, MainPageModel mainPageModel, Widget child) {
        DateTime _lastPressedAt; //上次点击时间
        return WillPopScope(
          onWillPop: () async {
            if (_lastPressedAt == null ||
                DateTime.now().difference(_lastPressedAt) >
                    Duration(seconds: 2)) {
              //两次点击间隔超过1秒则重新计时
              _lastPressedAt = DateTime.now();
              MyToast.showToast(msg: "再按一次退出"); //短提示
              return false;
            }
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return true;
          },
          child: Scaffold(
            backgroundColor: _themeModel.pageBackgroundColor1,
            body: PageView(
              controller: mainPageModel.controllerPage, //当前页面第几项
              children: <Widget>[
                child,
                ClassifyPage(),
                Container(),
                CartsPageMain(
                  showHead: true,
                ),
                HomePage(),
              ], //页面
              physics: NeverScrollableScrollPhysics(), //关闭滑动
            ),
            bottomNavigationBar: BottomNavigationBar(
                elevation: 5,
                backgroundColor: _themeModel.pageBackgroundColor2,
                currentIndex: mainPageModel.currentIndex,
                //高亮项数（int）
                onTap: (index) {
                  if (index == 2) return;
                  mainPageModel.bottomNavigationBarClick(index);
                },
                //点击时触发回调函数，回调参数是当前点击项数
                type: BottomNavigationBarType.fixed,
                //内置样式类型
                items: [
                  //选项条目
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home, color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.home,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '首页',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 0
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list, color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.list,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '分类',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 1
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.whatshot), title: Text("")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart,
                          color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.shopping_cart,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '购物车',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 3
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.person, color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.person,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '我的',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 4
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                ]),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: GestureDetector(
              child: Card(
                color: _themeModel.pageBackgroundColor2,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                margin: EdgeInsets.only(top: 20),
                child: Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(5),
//                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(30),
                      ),
                  child: Image.asset(
                    'static_images/middle_button.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              onTap: () {
//                Application.router.navigateTo(context,
//                    'search_goods_complete?keyword=${base64UrlEncode(utf8.encode("特价捡漏"))}&showKeyword=false');

                Application.router.navigateTo(context, '/activity01');
              },
            ),
          ),
        );
      }),
    );
  }
}
