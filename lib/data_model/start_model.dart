import 'dart:convert';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/models/classifyItem.dart';
import 'package:flutter_app/models/classifyList.dart';
import 'package:flutter_app/models/getVersionInfo.dart';
import 'package:flutter_app/models/goodsItem.dart';
import 'package:flutter_app/models/indexAdItem.dart';
import 'package:flutter_app/models/indexInfo.dart';
import 'package:flutter_app/models/userInfo.dart';
import 'package:flutter_app/request/fetch_classify_list.dart';
import 'package:flutter_app/request/fetch_index_info.dart';
import 'package:flutter_app/sqflite_model/base_sqflite.dart';
import 'package:flutter_app/sqflite_model/cart_sqflite.dart';
import 'package:flutter_app/sqflite_model/classify_sqflite.dart';
import 'package:flutter_app/sqflite_model/goods_sqflite.dart';
import 'package:flutter_app/sqflite_model/index_ad_sqflite.dart';
import 'package:flutter_app/sqflite_model/user_sqflite.dart';
import 'cart_data_model.dart';
import 'classify_list_ad_model.dart';
import 'goods_list_data_model.dart';
import 'index_ad_list_data_model.dart';

class StartModel with ChangeNotifier {
  //bool initFinish = false;
  final GoodsListDataModel _goodsListData = GoodsListDataModel();
  final IndexAdListDataModel _indexAdListData = IndexAdListDataModel();
  final ClassifyListDataModel _classifyListData = ClassifyListDataModel();
  final CartDataModel _cartData = CartDataModel();
  final UserInfoModel _userInfoData = UserInfoModel();
  GetVersionInfo _getVersionInfo;

  GoodsListDataModel get goodsListData => _goodsListData;

  IndexAdListDataModel get indexAdListData => _indexAdListData;

  ClassifyListDataModel get classifyListData => _classifyListData;

  CartDataModel get cartData => _cartData;

  UserInfoModel get userInfoData => _userInfoData;

  GetVersionInfo get getVersionInfo => _getVersionInfo;

  set getVersionInfo(GetVersionInfo getVersionInfo) {
    if (getVersionInfo.result_code == "success" &&
        getVersionInfo.app_version != VERSION) {
      _getVersionInfo = getVersionInfo;
    }
  }

  Future<void> init() async {
    /*配置文件*/
    List<Map<String, dynamic>> configSqlQueryAll =
        await BaseSqflite.db.query(CONFIG_TABLE_NAME);
    int nowDateTime = DateTime.now().millisecondsSinceEpoch; //当前
    int indexInfoInvalidTime = 0; //首页失效时间
    int classifyListInvalidTime = 0; //分类失效时间
    if (configSqlQueryAll.length > 0) {
      configSqlQueryAll.forEach((Map<String, dynamic> mapItem) {
        switch (mapItem['config_key']) {
          case "index_info_invalid_time":
            indexInfoInvalidTime = int.parse(mapItem["config_value"]);
            break;
          case "classify_list_invalid_time":
            classifyListInvalidTime = int.parse(mapItem["config_value"]);
            break;
        }
      });
    }

    /*获取数据库信息*/
    //商品数据库
    List<Map<String, dynamic>> goodsSqlQueryAll =
        await GoodsSqflite().queryAll();
    //首页广告数据库
    List<Map<String, dynamic>> indexAdSqlQueryAll =
        await IndexAdSqflite().queryAll();
    //分类数据库
    List<Map<String, dynamic>> classifySqlQueryAll =
        await ClassifySqflite().queryAll();
    //购物车数据库
    List<Map<String, dynamic>> cartSqlQueryAll = await CartSqFlite().queryAll();
    //用户信息
    List<Map<String, dynamic>> _userInfoSqlQueryAll =
        await UserSqflite().queryAll();
    Map<String, dynamic> userInfoSqlQueryAll =
        _userInfoSqlQueryAll.length > 0 ? _userInfoSqlQueryAll[0] : {};

    /*初始化商品列表和首页广告*/
    if (goodsSqlQueryAll.length == 0 ||
        indexAdSqlQueryAll.length == 0 ||
        indexInfoInvalidTime <= nowDateTime) {
      IndexInfo indexInfoModel = await FetchIndexInfo.fetch();
      _goodsListData.init(goodsList: indexInfoModel.goods_list);
      _indexAdListData.init(indexList: indexInfoModel.ad_list);
      GoodsSqflite().insertAllDate<GoodsItem>(indexInfoModel.goods_list);
      IndexAdSqflite().insertAllDate<IndexAdItem>(indexInfoModel.ad_list);
    } else {
      _goodsListData.init(
          goodsList: goodsSqlQueryAll.map((map) {
        Map<String, dynamic> item = json.decode(json.encode(map));
        item["attribute"] = json.decode(item["attribute"]);
        return GoodsItem.fromJson(item);
      }).toList());
      _indexAdListData.init(
          indexList: indexAdSqlQueryAll.map((map) {
        return IndexAdItem.fromJson(map);
      }).toList());
    }

    /*初始化展示分类*/
    if (classifySqlQueryAll.length == 0 ||
        classifyListInvalidTime <= nowDateTime) {
      ClassifyList classifyList = await FetchClassifyList.fetch();
      _classifyListData.init(classifyList);
      ClassifySqflite().insertAllDate<Map<String, dynamic>>(
          classifyList.data.map((ClassifyItem item) {
        Map<String, dynamic> mapItem = item.toJson();
        mapItem.remove('children');
        return mapItem;
      }).toList());
    } else {
      final Map<String, dynamic> data = {"data": classifySqlQueryAll};
      _classifyListData.init(ClassifyList.fromJson(data));
    }
    /*初始化购物车*/
    List<CartItem> cartList =
        cartSqlQueryAll.map((Map<String, dynamic> mapItem) {
      return CartItem.fromJson(mapItem);
    }).toList();
    _cartData.init(cartList: cartList);

    /*初始化用户信息*/
    if (userInfoSqlQueryAll.length > 0) {
      _userInfoData.init(UserInfo.fromJson(userInfoSqlQueryAll));
    }
  }
}
