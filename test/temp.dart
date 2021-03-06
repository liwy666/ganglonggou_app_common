import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/classify_list_ad_model.dart';
import 'package:flutter_app/data_model/main_page_model.dart';
import 'package:flutter_app/data_model/start_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/page/carts_page/carts_page.dart';
import 'package:flutter_app/page/classify_page/classify_page.dart';
import 'package:flutter_app/page/first_page/first_page.dart';
import 'package:flutter_app/page/home_page/home_page.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  int currentIndex;
  StartModel _startModel;
  final bool needUpdateApp;

  MainPage({@required this.currentIndex, this.needUpdateApp});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return ProviderWidget<MainPageModel>(
      model: MainPageModel(currentIndex: currentIndex),
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
              Fluttertoast.showToast(msg: "再按一次退出"); //短提示
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
                CartsPageMain(
                  showHead: true,
                ),
                HomePage(),
              ], //页面
              physics: NeverScrollableScrollPhysics(), //关闭滑动
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: _themeModel.pageBackgroundColor2,
                currentIndex: mainPageModel.currentIndex,
                //高亮项数（int）
                onTap: (index) {
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
                      icon: Icon(Icons.shopping_cart,
                          color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.shopping_cart,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '购物车',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 2
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                  BottomNavigationBarItem(
                      icon:
                      Icon(Icons.person, color: _themeModel.fontColor2),
                      activeIcon: Icon(Icons.person,
                          color: Theme.of(context).accentColor),
                      title: Text(
                        '我的',
                        style: TextStyle(
                            fontSize: mainPageModel.defaultFontSize,
                            color: mainPageModel.currentIndex != 3
                                ? _themeModel.fontColor2
                                : Theme.of(context).accentColor),
                      )),
                ]),
          ),
        );
      }),
    );
  }
}
