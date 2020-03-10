import 'dart:async';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/userInfo.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/request/fetch_user_info.dart';
import 'package:ganglong_shop_app/request/post_register_by_email.dart';
import 'package:ganglong_shop_app/request/post_retrieve_password_by_email.dart';
import 'package:ganglong_shop_app/request/post_send_email_verify_code.dart';
import 'package:ganglong_shop_app/request/post_send_retrieve_password_or_login_email_verify_code.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RetrievePasswordPageModel with ChangeNotifier {
  bool _nonePassword = true;
  bool _noneAgainPassword = true;
  bool _verifying = false;
  int _countDown = 60;
  Timer _timer;
  String _emailAddress = "";
  String _verifyCode = "";
  String _password = "";
  String _againPassword = "";

  bool get nonePassword => _nonePassword;

  bool get noneAgainPassword => _noneAgainPassword;

  bool get verifying => _verifying;

  String get getCodeButtonLabel {
    if (!_verifying) {
      return "获取验证码";
    } else {
      return "${_countDown}s后重新获取";
    }
  }

  set setNonePassword(bool value) {
    this._nonePassword = value;
    notifyListeners();
  }

  set setNoneAgainPassword(bool value) {
    this._noneAgainPassword = value;
    notifyListeners();
  }

  set setEmailAddress(String emailAddress) {
    _emailAddress = emailAddress;
  }

  set setVerifyCode(String verifyCode) {
    _verifyCode = verifyCode;
  }

  set setPassword(String password) {
    _password = password;
  }

  set setAgainPassword(String againPassword) {
    _againPassword = againPassword;
  }

  @override
  void dispose() {
    _cancelTimer();
    // TODO: implement dispose
    super.dispose();
  }

  Future sendVerifyCode() async {
    if (_verifying == true) return;
    if (!checkEmailAddress(_emailAddress)) return;
    bool sendResult =
    await PostSendRetrievePasswordOrLoginEmailVerifyCode.post(emailAddress: _emailAddress);

    if (sendResult) {
      _verifying = true;
      notifyListeners();
      _timer = Timer.periodic(Duration(milliseconds: 1000), (_) {
        _countDown--;
        notifyListeners();
        if (_countDown <= 0) {
          _timer.cancel();
          _verifying = false;
          _countDown = 60;
          notifyListeners();
        }
      });
    }
  }

  Future<UserInfo> registerAccounts() async {
    if (!checkEmailAddress(_emailAddress)) return null;
    if (_verifyCode == null || _verifyCode.length < 6 || _verifyCode.isEmpty) {
      MyToast.showToast(msg: "请填写6位验证码"); //短提示
      return null;
    }
    if (!checkPasswordHard(_password)) return null;
    if (_password != _againPassword) {
      MyToast.showToast(msg: "两次密码填写不一致"); //短提示
      return null;
    }

    String userToken = await PostRetrievePasswordByEmail.post(
        emailAddress: _emailAddress,
        password: _password,
        verifyCode: _verifyCode);
    //请求用户信息
    UserInfo userInfo = await FetchUserInfo.fetch(userToken: userToken);
    return userInfo;
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
