import 'package:fluro/fluro.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/page/error_page/not_found_route_page.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:ganglong_shop_app/routes/route_handlers.dart';

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
  static String couponList = '/coupon_list';
  static String notFoundRoute = '/not_found_route';
  static String activityOnePage = '/activity01';
  static String boot = '/boot';

  ///功能测试
  static String test = '/test';
  static String testBoot = '/test_boot';
  static String testAnimation = '/test_animation';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("没有找到路由");
      return NotFoundRoutePage();
    });

    router.define(root, handler: startHandler); //默认

    router.define(start, handler: startHandler); //启动页

    router.define(main,
        handler: rootHandler, transitionType: TransitionType.fadeIn); //主页

    router.define(goods,
        handler: goodsHandler, transitionType: TransitionType.cupertino); //商品详情

    router.define(evaluateList,
        handler: evaluateListHandler,
        transitionType: TransitionType.cupertino); //商品评价列表

    router.define(carts,
        handler: cartsHandler,
        transitionType: TransitionType.cupertino); //购物车列表

    router.define(logon,
        handler: logonHandler,
        transitionType: TransitionType.inFromRight); //登录页

    router.define(register,
        handler: registerHandler,
        transitionType: TransitionType.cupertino); //注册页

    router.define(retrievePassword,
        handler: retrievePasswordHandler,
        transitionType: TransitionType.cupertino); //找回密码页

    router.define(writeOrder,
        handler: writeOderHandler,
        transitionType: TransitionType.cupertino); //填写订单

    router.define(readOrder,
        handler: readOderHandler,
        transitionType: TransitionType.cupertino); //订单详情

    router.define(orderList,
        handler: orderListHandler,
        transitionType: TransitionType.cupertino); //订单列表

    router.define(addressList,
        handler: addressListHandler,
        transitionType: TransitionType.cupertino); //地址管理

    router.define(editAddress,
        handler: editAddressHandler,
        transitionType: TransitionType.cupertino); //地址编辑

    router.define(userCouponList,
        handler: userCouponListHandler,
        transitionType: TransitionType.cupertino); //用户优惠券列表

    router.define(picSwiper,
        handler: picSwiperHandler,
        transitionType: TransitionType.inFromBottom); //图片预览

    router.define(editUserInfo,
        handler: editUserInfoHandler,
        transitionType: TransitionType.cupertino); //编辑用户资料

    router.define(webView,
        handler: webViewHandler,
        transitionType: TransitionType.inFromRight); //webView

    router.define(searchGoods,
        handler: searchGoodsHandler,
        transitionType: TransitionType.cupertino); //商品搜索

    router.define(searchGoodsComplete,
        handler: searchGoodsCompleteHandler,
        transitionType: TransitionType.cupertino); //商品搜索结果

    router.define(askAfterService,
        handler: askAfterServiceHandler,
        transitionType: TransitionType.cupertino); //申请售后

    router.define(submitEvaluate,
        handler: submitEvaluateHandler,
        transitionType: TransitionType.cupertino); //提交评价

    router.define(config,
        handler: configHandler,
        transitionType: TransitionType.cupertino); //设置中心

    router.define(supplier,
        handler: supplierHandler,
        transitionType: TransitionType.cupertino); //供应商

    router.define(couponList,
        handler: couponListHandler,
        transitionType: TransitionType.cupertino); //优惠券列表

    router.define(activityOnePage,
        handler: activityOneHandler,
        transitionType: TransitionType.cupertino); //活动页01

    router.define(notFoundRoute,
        handler: notFoundRouteHandler,
        transitionType: TransitionType.cupertino); //没有找到路由

    router.define(boot,
        handler: bootHandler,
        transitionType: TransitionType.inFromRight); //初次引导页

    ///功能测试
    router.define(test,
        handler: testHandler,
        transitionType: TransitionType.inFromRight); //测试页面
    router.define(testBoot,
        handler: testBootHandler,
        transitionType: TransitionType.cupertino); //启动页测试页面
    router.define(testAnimation,
        handler: testAnimationHandler,
        transitionType: TransitionType.cupertino); //动画页测试页面
  }
}
