import 'package:fluro/fluro.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/routes/route_handlers.dart';

class Routes {
  static String root = "/";
  static String start = "/start";
  static String main = "/main";
  static String goods = "/goods";
  static String evaluateList = "/evaluate_list";
  static String carts = "/carts";
  static String logon = "/logon";
  static String writeOrder = "/write_order";
  static String readOrder = "/read_order";
  static String addressList = "/address_list";
  static String editAddress = "/edit_address";
  static String orderList = "/order_list";
  static String userCouponList = "/user_coupon_list";
  static String picSwiper = "/pic_swiper";
  static String register = "/register";
  static String editUserInfo = "/edit_user_info";
  static String retrievePassword = "/retrieve_password";
  static String webView = '/web_view';
  static String searchGoods = '/search_goods';
  static String searchGoodsComplete = '/search_goods_complete';
  static String askAfterService = '/ask_after_service';
  static String submitEvaluate = '/submit_evaluate';
  static String config = '/config';
  static String supplier = '/supplier';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return;
    });

    router.define(root, handler: startHandler); //默认

    router.define(start, handler: startHandler); //启动页

    router.define(main, handler: rootHandler); //主页

    router.define(goods,
        handler: goodsHandler,
        transitionType: TransitionType.inFromRight); //商品详情

    router.define(evaluateList,
        handler: evaluateListHandler,
        transitionType: TransitionType.inFromRight); //商品评价列表

    router.define(carts,
        handler: cartsHandler,
        transitionType: TransitionType.inFromRight); //购物车列表

    router.define(logon,
        handler: logonHandler,
        transitionType: TransitionType.inFromRight); //登录页

    router.define(register,
        handler: registerHandler,
        transitionType: TransitionType.inFromRight); //注册页

    router.define(retrievePassword,
        handler: retrievePasswordHandler,
        transitionType: TransitionType.inFromRight); //找回密码页

    router.define(writeOrder,
        handler: writeOderHandler,
        transitionType: TransitionType.inFromRight); //填写订单

    router.define(readOrder,
        handler: readOderHandler,
        transitionType: TransitionType.inFromRight); //订单详情

    router.define(orderList,
        handler: orderListHandler,
        transitionType: TransitionType.inFromRight); //订单列表

    router.define(addressList,
        handler: addressListHandler,
        transitionType: TransitionType.inFromRight); //地址管理

    router.define(editAddress,
        handler: editAddressHandler,
        transitionType: TransitionType.inFromRight); //地址编辑

    router.define(userCouponList,
        handler: userCouponListHandler,
        transitionType: TransitionType.inFromRight); //用户优惠券列表

    router.define(picSwiper,
        handler: picSwiperHandler,
        transitionType: TransitionType.inFromBottom); //图片预览

    router.define(editUserInfo,
        handler: editUserInfoHandler,
        transitionType: TransitionType.inFromRight); //编辑用户资料

    router.define(webView,
        handler: webViewHandler,
        transitionType: TransitionType.inFromRight); //webView

    router.define(searchGoods,
        handler: searchGoodsHandler,
        transitionType: TransitionType.inFromRight); //商品搜索

    router.define(searchGoodsComplete,
        handler: searchGoodsCompleteHandler,
        transitionType: TransitionType.inFromRight); //商品搜索结果

    router.define(askAfterService,
        handler: askAfterServiceHandler,
        transitionType: TransitionType.inFromRight); //申请售后

    router.define(submitEvaluate,
        handler: submitEvaluateHandler,
        transitionType: TransitionType.inFromRight); //提交评价

    router.define(config,
        handler: configHandler,
        transitionType: TransitionType.inFromRight); //设置中心

    router.define(supplier,
        handler: supplierHandler,
        transitionType: TransitionType.inFromRight); //供应商
  }
}
