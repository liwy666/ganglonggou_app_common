import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/address_list_page/address_list_page.dart';
import 'package:flutter_app/page/ask_after_service_page/ask_after_service_page.dart';
import 'package:flutter_app/page/carts_page/carts_page.dart';
import 'package:flutter_app/page/config_page/config_page.dart';
import 'package:flutter_app/page/edit_address_page/edit_address_page.dart';
import 'package:flutter_app/page/edit_user_info_page/edit_user_info_page.dart';
import 'package:flutter_app/page/evaluate_list_page/evaluate_list_page.dart';
import 'package:flutter_app/page/goods_page/goods_page.dart';
import 'package:flutter_app/page/logon_page/logon_page.dart';
import 'package:flutter_app/page/main_page/main_page.dart';
import 'package:flutter_app/page/order_list_page/order_list_page.dart';
import 'package:flutter_app/page/pic_swiper/pic_swiper.dart';
import 'package:flutter_app/page/read_order_page/read_order_page.dart';
import 'package:flutter_app/page/register_page/register_page.dart';
import 'package:flutter_app/page/retrieve_password_page/retrieve_password_page.dart';
import 'package:flutter_app/page/search_goods_complete_page/search_goods_complete_page.dart';
import 'package:flutter_app/page/search_goods_page/search_goods_page.dart';
import 'package:flutter_app/page/start_page/start_page.dart';
import 'package:flutter_app/page/submit_evaluate_page/submit_evaluate_page.dart';
import 'package:flutter_app/page/supplier_page/supplier_page.dart';
import 'package:flutter_app/page/user_coupon_list_page/user_coupon_list_page.dart';
import 'package:flutter_app/page/web_view_page/web_view_page.dart';
import 'package:flutter_app/page/write_order_page/write_order_page.dart';

/*启动页*/
Handler startHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return StartPage();
});

/*主页*/
Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int currentIndex = int.parse(
      params["currentIndex"] != null ? params["currentIndex"].first : "0");
  bool needUpdateApp = params["needUpdateApp"].first == 'true' ? true : false;
  return MainPage(
    currentIndex: currentIndex,
    needUpdateApp: needUpdateApp,
  );
});

/*商品详情*/
Handler goodsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int goodsId = int.parse(params["goodsId"]?.first);
  return GoodsPage(goodsId: goodsId);
});

/*商品评价列表*/
Handler evaluateListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int goodsId = int.parse(params["goodsId"]?.first);
  return EvaluateListPage(goodsId: goodsId);
});

/*购物车*/
Handler cartsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartsPage(
    showHead: false,
  );
});

/*登录页*/
Handler logonHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  bool showBar = params["showBar"]?.first == 'true' ? true : false;
  return LogonPage(
    showBar: showBar,
  );
});

/*注册页*/
Handler registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});

/*找回密码页*/
Handler retrievePasswordHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RetrievePasswordPage();
});

/*填写订单*/
Handler writeOderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return WriteOrderPage();
});

/*订单详情*/
Handler readOderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String orderSn = params['orderSn']?.first;
  return ReadOrderPage(
    orderSn: orderSn,
  );
});

/*订单列表*/
Handler orderListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String watchType =
      params["watchType"] == null ? 'all' : params['watchType'].first;
  return OrderListPage(
    watchType: watchType,
  );
});

/*收货地址管理*/
Handler addressListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String intoUrl = params["intoUrl"] == null
      ? 'main?currentIndex=$HOME_INDEX'
      : params['intoUrl'].first;
  return AddressListPage(
    intoUrl: '/$intoUrl',
  );
});

/*收货地址编辑*/
Handler editAddressHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String code = params["addressItemJson"]?.first;
  String addressItemJson =
      code != null ? utf8.decode(base64Decode(code)) : null;
  String editType = params["editType"]?.first;
  String intoUrl = params["intoUrl"] == null
      ? 'main?currentIndex=$HOME_INDEX'
      : params['intoUrl'].first;
  return EditAddressPage(
    addressItemJson: addressItemJson,
    editType: editType,
    intoUrl: '/$intoUrl',
  );
});

/*用户优惠券列表*/
Handler userCouponListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserCouponListPage();
});

/*图片预览*/
Handler picSwiperHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String code = params["imgUrlListCode"]?.first;
  String index = params["index"]?.first;
  String imgUrlListJson = code != null ? utf8.decode(base64Decode(code)) : null;
  List<dynamic> imgUrlList = jsonDecode(imgUrlListJson)
    ..map((dynamic mapItem) {
      return Map<String, String>.from(mapItem);
    }).toList();
  return PicSwiper(
    index: int.parse(index),
    pics: imgUrlList.map((dynamic item) {
      return PicSwiperItem(item["url"]);
    }).toList(),
  );
});

/*资料编辑*/
Handler editUserInfoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EditUserInfoPage();
});

/*WebView*/
Handler webViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String code = params["initialLink"]?.first;
  String titleCode = params["title"]?.first;
  String initialLink = code != null ? utf8.decode(base64Decode(code)) : null;
  String title =
      titleCode != null ? utf8.decode(base64Decode(titleCode)) : null;
  return WebViewPage(
    initialLink: initialLink,
    title: title,
  );
});

/*商品搜索*/
Handler searchGoodsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchGoodsPage();
});

/*商品搜索结果页*/
Handler searchGoodsCompleteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String code = params["keyword"]?.first;
  bool showKeyword = params["showKeyword"]?.first == 'false' ? false : true;
  String keyword = code != null ? utf8.decode(base64Decode(code)) : null;
  return SearchGoodsCompletePage(
    keyword: keyword,
    showKeyword: showKeyword,
  );
});

/*申请售后*/
Handler askAfterServiceHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String orderSn = params['orderSn']?.first;
  return AskAfterServicePage(
    orderSn: orderSn,
  );
});

/*提交评价*/
Handler submitEvaluateHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String midOrderJson =
      utf8.decode(base64Decode(params['midOrderJson']?.first));
  MidOrderItem midOrderItem = MidOrderItem.fromJson(jsonDecode(midOrderJson));
  return SubmitEvaluatePage(
    midOrderItem: midOrderItem,
  );
});

/*设置中心*/
Handler configHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ConfigPage();
});

/*供应商页面*/
Handler supplierHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String supplierPreviewInfoJson =
      utf8.decode(base64Decode(params['supplierPreviewInfoJson']?.first));
  SupplierPreviewInfo supplierPreviewInfo =
      SupplierPreviewInfo.fromJson(jsonDecode(supplierPreviewInfoJson));
  return SupplierPage(
    supplierPreviewInfo: supplierPreviewInfo,
  );
});
