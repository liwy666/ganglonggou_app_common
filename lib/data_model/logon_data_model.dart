import 'package:fake_wechat/fake_wechat.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_ali_pay_merchant_private_key.dart';
import 'package:ganglong_shop_app/request/fetch_user_info.dart';
import 'package:ganglong_shop_app/request/post_user_alipay_logon.dart';
import 'package:ganglong_shop_app/request/post_user_logon.dart';
import 'package:ganglong_shop_app/request/post_user_wechat_logon.dart';
import 'package:ganglong_shop_app/service/alipay_service.dart';
import 'package:ganglong_shop_app/service/wechat_service.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LogonDataModel with ChangeNotifier {
  String _phoneNumber;
  String _emailAddress;
  String _password;
  final BuildContext pageContext;
  final UserInfoModel userInfoModel;
  WeChatService _weChatService;
  AliPayService _aliPayService;

  set setPhoneNumber(String phoneNumber) {
    this._phoneNumber = phoneNumber;
  }

  set setPassword(String password) {
    this._password = password;
  }

  set setEmailAddress(String emailAddress) {
    this._emailAddress = emailAddress;
  }

  LogonDataModel({@required this.pageContext, @required this.userInfoModel});

  /*登录成功*/
  Future<void> _logonSuccess(String userToken) async {
    if (userToken.length == USER_TOKEN_LENGTH) {
      MyLoading.eject();
      try {
        //请求用户信息
        UserInfo userInfo = await FetchUserInfo.fetch(userToken: userToken);
        //更新全局UserModel
        await userInfoModel.userLogonSuccess(userInfo: userInfo);
      } catch (e) {
        print(e);
      } finally {
        MyLoading.shut();
        //跳转主页
        Navigator.of(pageContext)
            .pushReplacementNamed('/main?currentIndex=$HOME_INDEX');
      }
    }
  }

  /*用户账号登录*/
  Future<UserInfo> logon() async {
    //输入验证
/*
   //手机号
   RegExp mobile = new RegExp(
        r"(0|86|17951)?(13[0-9]|15[0-35-9]|17[0678]|18[0-9]|14[57])[0-9]{8}");
    if (_phoneNumber == null ||
        _phoneNumber.isEmpty ||
        !mobile.hasMatch(_phoneNumber)) {
      Fluttertoast.showToast(msg: "填写的手机号不符合规范"); //短提示
      return null;
    }*/

    if (!checkEmailAddress(_emailAddress)) return null;
    if (_password == null ||
        _password.toString().length > 18 ||
        _password.toString().isEmpty) {
      Fluttertoast.showToast(msg: "填写的密码不符合规范"); //短提示
      return null;
    }
    //向后台获取Token
    String userToken = await PostUserLogon.post(
        emailAddress: _emailAddress, password: _password);
    //请求用户信息
    UserInfo userInfo = await FetchUserInfo.fetch(userToken: userToken);
    return userInfo;
  }

  /*微信登录*/
  Future<void> weChatLogon() async {
    _weChatService = WeChatService(
        weChatSignInAuthorizeSuccess: (WechatAuthResp resp) async {
      MyLoading.eject();
      String userToken;
      try {
        userToken = await PostUserWeChatLogon.post(code: resp.code);
      } catch (e) {
        print(e);
      } finally {
        MyLoading.shut();
        _logonSuccess(userToken);
      }
    });

    if (!await _weChatService.weChat.isWechatInstalled() ||
        !await _weChatService.weChat.isWechatSupportApi()) {
      Fluttertoast.showToast(msg: "您需要先安装微信"); //短提示
      return;
    }

    _weChatService.weChat.auth(
      scope: <String>[WechatScope.SNSAPI_USERINFO],
      state: 'auth',
    );
  }

  /*支付宝登录*/
  Future<void> aliApyLogon() async {
    _aliPayService = AliPayService(aliPaySignInAuthorizeSuccess:
        (AliPayAuthRespInfo aliPayAuthRespInfo) async {
      MyLoading.eject();
      String userToken;
      try {
        userToken =
            await PostUserAliPayLogon.post(code: aliPayAuthRespInfo.auth_code);
      } catch (e) {
        print(e);
      } finally {
        MyLoading.shut();
        _logonSuccess(userToken);
      }
    });

    if (!await _aliPayService.aliPay.isAlipayInstalled()) {
      Fluttertoast.showToast(msg: "您需要先安装支付宝"); //短提示
      return;
    }

    MyLoading.eject();
    try {
      String privateKeyDesBase64 = await FetchAliPayMerchantPrivateKey.fetch();
      print(privateKeyDesBase64.length);
      String privateKey = await FlutterDes.decryptFromBase64(
          privateKeyDesBase64, DES_KEY,
          iv: DES_VI);

      _aliPayService.aliPay.auth(
          appId: ALIPAY_APPID,
          pid: ALIPAY_PID,
          targetId: ALIPAY_TARGETID,
          privateKey:
              '-----BEGIN RSA PRIVATE KEY-----\n$privateKey\n-----END RSA PRIVATE KEY-----');
    } catch (e) {
      print(e);
    } finally {
      MyLoading.shut();
    }
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
