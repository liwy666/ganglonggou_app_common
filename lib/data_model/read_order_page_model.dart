import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/order_data_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_alipay_prepay_info.dart';
import 'package:ganglong_shop_app/request/fetch_order_info.dart';
import 'package:ganglong_shop_app/request/fetch_wechat_prepay_info.dart';
import 'package:ganglong_shop_app/request/post_call_order.dart';
import 'package:ganglong_shop_app/request/post_cancel_after_service.dart';
import 'package:ganglong_shop_app/request/post_delete_order.dart';
import 'package:ganglong_shop_app/request/post_take_order.dart';
import 'package:ganglong_shop_app/service/alipay_service.dart';
import 'package:ganglong_shop_app/service/wechat_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReadOrderPageModel with ChangeNotifier {
  bool _loadingFinish = false;
  OrderInfo _orderInfo;
  final String orderSn;
  final String userToken;
  final OrderDataModel orderDataModel;
  WeChatService _weChatService;
  AliPayService _aliPayService;

  bool get loadingFinish => _loadingFinish;

  OrderInfo get orderInfo => _orderInfo;

  ReadOrderPageModel(
      {@required this.orderSn,
      @required this.userToken,
      @required this.orderDataModel});

  Future<void> init() async {
    _orderInfo =
        await FetchOrderInfo.fetch(userToken: userToken, orderSn: orderSn);
    _loadingFinish = true;
    notifyListeners();
  }

  ///支付订单
  void orderPayment() {
    switch (orderInfo.pay_code) {
      case "WxAppApiPayment":
        _weChatAppPayment();
        break;
      case "AppAliPayment":
        _aliPayAppPayment();
        break;
      default:
        Fluttertoast.showToast(
            msg: "此客户端暂不支持该付款方式，对此给您带来的不便我们深感抱歉",
            timeInSecForIos: 2,
            gravity: ToastGravity.CENTER);
        break;
    }
  }

  ///取消订单
  Future<void> orderCancel() async {
    MyLoading.eject();
    try {
      await PostCallOrder.post(userToken: userToken, orderSn: orderSn);
      init();
      await orderDataModel.reFresh(userToken);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///删除订单
  Future<void> orderDelete() async {
    MyLoading.eject();
    try {
      await PostDeleteOrder.post(userToken: userToken, orderSn: orderSn);
      await orderDataModel.reFresh(userToken);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///签收订单
  Future<void> orderTake() async {
    MyLoading.eject();
    try {
      await PostTakeOrder.post(userToken: userToken, orderSn: orderSn);
      init();
      await orderDataModel.reFresh(userToken);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///取消售后
  Future<void> cancelAfterService() async {
    MyLoading.eject();
    try {
      await PostCancelAfterService.post(userToken: userToken, orderSn: orderSn);
      init();
      await orderDataModel.reFresh(userToken);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///微信支付
  Future<void> _weChatAppPayment() async {
    MyLoading.eject();
    try {
      WeChatPrepayInfo weChatPrepayInfo = await FetchWeChatPrepayInfo.fetch(
          userToken: userToken, orderSn: orderInfo.order_sn);

      if (weChatPrepayInfo.return_code != 'SUCCESS' ||
          weChatPrepayInfo.result_code != 'SUCCESS') {
        Fluttertoast.showToast(msg: "好像出错了，再试一次吧");
        return;
      }
      _weChatService = WeChatService(weChatPaySuccess: (_) {
        _paySuccess();
      })
        ..weChat.pay(
            appId: WECHAT_APPID,
            partnerId: weChatPrepayInfo.mch_id,
            prepayId: weChatPrepayInfo.prepay_id,
            package: WECHAT_PAY_PACKAGE,
            nonceStr: weChatPrepayInfo.nonce_str,
            timeStamp: weChatPrepayInfo.timestamp,
            sign: weChatPrepayInfo.sign);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///支付宝支付
  Future<void> _aliPayAppPayment() async {
    MyLoading.eject();
    try {
      String aliPayPrepayInfo = await FetchAliPayPrepayInfo.fetch(
          userToken: userToken, orderSn: orderInfo.order_sn);
      if (aliPayPrepayInfo == null || aliPayPrepayInfo.isEmpty) {
        Fluttertoast.showToast(msg: "好像出错了，再试一次吧");
        return;
      }
      _aliPayService = AliPayService(aliPayPaySuccess: (_) {
        _paySuccess();
      })
        ..aliPay.payOrderSign(orderInfo: aliPayPrepayInfo);
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
  }

  ///支付成功后回调
  Future<void> _paySuccess() async {
    MyLoading.eject();
    await Future.delayed(Duration(seconds: 2));
    init();
    await orderDataModel.reFresh(userToken);
    MyLoading.shut();
  }

  @override
  void dispose() {
    if (_weChatService != null) {
      _weChatService.cancel();
    }
    if (_aliPayService != null) {
      _aliPayService.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
