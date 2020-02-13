import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:ganglong_shop_app/data_model/address_list_model.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/goods_list_data_model.dart';
import 'package:ganglong_shop_app/data_model/index_ad_list_data_model.dart';
import 'package:ganglong_shop_app/data_model/order_data_model.dart';
import 'package:ganglong_shop_app/data_model/start_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:ganglong_shop_app/routes/routes.dart';
import 'package:ganglong_shop_app/sqflite_model/base_sqflite.dart';
import 'package:ganglong_shop_app/sqflite_model/sqlfite_config.dart';
import 'package:provider/provider.dart';
import 'package:ganglong_shop_app/common_import.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _runApp();
}

Future<Null> _runApp() async {
  /*初始化http*/
  initHttp();
  /*初始化数据库*/
  await BaseSqflite.initSql();
  List<Map<String, dynamic>> configSqlQueryAll =
      await BaseSqflite.db.query(CONFIG_TABLE_NAME);
  String themeMode = "default";
  if (configSqlQueryAll.length > 0) {
    configSqlQueryAll.forEach((Map<String, dynamic> mapItem) {
      switch (mapItem['config_key']) {
        case "theme_mode":
          themeMode = mapItem["config_value"];
          break;
      }
    });
  }
  /*初始化主题模式*/
  final themeModel = ThemeModel();
  themeModel.init(themeMode);
  /*start_model*/
  StartModel startModel = StartModel();
  /*注册model*/
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<StartModel>.value(value: startModel),
      ChangeNotifierProvider<GoodsListDataModel>.value(
          value: startModel.goodsListData),
      ChangeNotifierProvider<IndexAdListDataModel>.value(
          value: startModel.indexAdListData),
      ChangeNotifierProvider<ClassifyListDataModel>.value(
          value: startModel.classifyListData),
      ChangeNotifierProvider<CartDataModel>.value(value: startModel.cartData),
      ChangeNotifierProvider<UserInfoModel>.value(
          value: startModel.userInfoData),
      ChangeNotifierProvider<AddressListModel>.value(value: AddressListModel()),
      ChangeNotifierProvider<OrderDataModel>.value(value: OrderDataModel()),
      ChangeNotifierProvider<ThemeModel>.value(value: themeModel),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp() {
    //初始化路由
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return MaterialApp(
      //home: HomeContent(),
      theme: ThemeData(
          primarySwatch: _themeModel.themeColor,
          //platform: TargetPlatform.iOS //右滑返回
          ),
      onGenerateRoute: Application.router.generator,
    );
  }
}

/**
 * 因使用路由而废弃
 * class HomeContent extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
    Loading.ctx = context;
    // TODO: implement build
    return Scaffold(
    body: MainPage(),
    );
    }
    }*/
