import 'dart:async';
import 'dart:convert';

import 'package:fake_alipay/fake_alipay.dart';
import 'package:ganglong_shop_app/models/AliPayAuthRespInfo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';

class AliPayService {
  StreamSubscription<AlipayResp> _pay;
  StreamSubscription<AlipayResp> _auth;
  final void Function(AliPayAuthRespInfo aliPayAuthRespInfo)
      aliPaySignInAuthorizeSuccess;
  final void Function(AlipayResp resp) aliPayPaySuccess;
  Alipay aliPay = Alipay();

  AliPayService({this.aliPaySignInAuthorizeSuccess, this.aliPayPaySuccess}) {
    _pay = aliPay.payResp().listen(_listenPay);
    _auth = aliPay.authResp().listen(_listenAuth);
  }

  void _listenPay(AlipayResp resp) {
    String content = 'pay: ${resp.resultStatus} - ${resp.result}';
    print('支付：$content');

    switch (resp.resultStatus) {
      case 9000:
        if (aliPayPaySuccess != null) {
          aliPayPaySuccess(resp);
        }
        break;
      case 8000:
        MyToast.showToast(msg: "支付正在处理中");
        break;
      case 8000:
        MyToast.showToast(msg: "支付正在处理中");
        break;
      case 4000:
        MyToast.showToast(msg: "订单支付失败");
        break;
      case 5000:
        MyToast.showToast(msg: "重复发起支付");
        break;
      case 6001:
        MyToast.showToast(msg: "您取消了支付");
        break;
      case 6002:
        MyToast.showToast(msg: "网络连接出错");
        break;
      default:
        MyToast.showToast(msg: "授权过程中发生未知错误");
        break;
    }
  }

  void _listenAuth(AlipayResp resp) {
 /*   print(jsonEncode(res));
    {"success":"true",
    "result_code":"200",
    "app_id":"2017110609764829",
    "auth_code":"ad3fe2191897441daa3d86842724QX40",
     "scope":"kuaijie",
     "alipay_open_id":"20880050551716885137578560816740",
     "user_id":"2088702746395409",
     "target_id":"1574405082"}*/
//    String content = 'pay: ${resp.resultStatus} - ${resp.result}';
//    print('授权登录：$content');

    switch (resp.resultStatus) {
      case 9000:
        List<String> arrStr = resp.result.split('&');
        Map<String, String> res = {};
        arrStr.forEach((String arrItem) {
          List<String> arrArr = arrItem.split('=');
          res[arrArr[0]] = arrArr[1];
        });
        AliPayAuthRespInfo _aliPayAuthRespInfo =
            AliPayAuthRespInfo.fromJson(res);
        if (_aliPayAuthRespInfo.success == 'true' &&
            _aliPayAuthRespInfo.result_code == '200' &&
            aliPaySignInAuthorizeSuccess != null) {
          aliPaySignInAuthorizeSuccess(_aliPayAuthRespInfo);
        } else {
          MyToast.showToast(msg: "授权过程中发生未知错误");
        }
        break;
      case 4000:
        MyToast.showToast(msg: "系统异常");
        break;
      case 6001:
        MyToast.showToast(msg: "您取消了授权");
        break;
      case 6002:
        MyToast.showToast(msg: "网络连接出错");
        break;
      default:
        MyToast.showToast(msg: "授权过程中发生未知错误");
        break;
    }
  }

  void cancel() {
    if (_pay != null) {
      _pay.cancel();
    }
    if (_auth != null) {
      _auth.cancel();
    }
  }
}

