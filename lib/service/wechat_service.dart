import 'dart:async';

import 'package:fake_wechat/fake_wechat.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WeChatService {
  StreamSubscription<WechatSdkResp> _share;
  StreamSubscription<WechatAuthResp> _auth;
  StreamSubscription<WechatPayResp> _pay;
  final void Function(WechatAuthResp resp) weChatSignInAuthorizeSuccess;
  final void Function(WechatPayResp resp) weChatPaySuccess;
  final Wechat weChat = Wechat()
    ..registerApp(
      appId: WECHAT_APPID,
      universalLink: "",
    );

  WeChatService({
    this.weChatSignInAuthorizeSuccess,
    this.weChatPaySuccess,
  }) {
    _share = weChat.shareMsgResp().listen(_listenShareMsg);
    _auth = weChat.authResp().listen(_listenWeChatLogon);
    _pay = weChat.payResp().listen(_listenPay);
  }

  void _listenShareMsg(WechatSdkResp resp) {
    String content = 'share: ${resp.errorCode} ${resp.errorMsg}';
    print("listenShareMsg:$content");
  }

  void _listenWeChatLogon(WechatAuthResp resp) {
    String content =
        '微信登录返回结果： ErrCode: ${resp.errorCode} errorMsg:${resp.errorMsg} code:${resp.code}';

    switch (resp.errorCode) {
      case 0:
        if (weChatSignInAuthorizeSuccess != null) {
          weChatSignInAuthorizeSuccess(resp);
        }
        break;
      case -4:
        Fluttertoast.showToast(msg: "您拒绝了授权");
        break;
      case -2:
        Fluttertoast.showToast(msg: "您取消了授权");
        break;
      default:
        Fluttertoast.showToast(msg: "发生未知错误");
        print(content);
        break;
    }
  }

  void _listenPay(WechatPayResp resp) {
    String content = 'pay: ${resp.errorCode} ${resp.errorMsg}';
    switch (resp.errorCode) {
      case 0:
        if (weChatPaySuccess != null) {
          weChatPaySuccess(resp);
        }
        break;
      case -1:
        Fluttertoast.showToast(msg: "发生支付错误");
        break;
      case -2:
        Fluttertoast.showToast(msg: "您取消了支付");
        break;
      default:
        Fluttertoast.showToast(msg: "发生未知错误");
        print(content);
        break;
    }
    print("监听支付结果$content");
  }

  void cancel() {
    if (_auth != null) {
      _auth.cancel();
    }
    if (_share != null) {
      _share.cancel();
    }
    if (_pay != null) {
      _pay.cancel();
    }
  }
}
