import 'package:flutter/gestures.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/data_model/register_page_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TapGestureRecognizer _recognizerUser = TapGestureRecognizer();
  final TapGestureRecognizer _recognizerPrivacy = TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    _recognizerUser.onTap = () {
      openUserAgreement(context);
    };
    _recognizerPrivacy.onTap = () {
      openPrivacyAgreement(context);
    };
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyTabBar(
        tabBarName: '注册',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(50),
            horizontal: ScreenUtil().setWidth(40)),
        child: ProviderWidget<RegisterPageModel>(
          model: RegisterPageModel(),
          builder:
              (BuildContext context, RegisterPageModel registerPageModel, _) {
            return ListView(
              //runSpacing: 20.0, // 纵轴（垂直）方向间距
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    registerPageModel.setEmailAddress = value;
                  },
                  decoration: InputDecoration(
                    labelText: "邮箱号",
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: EdgeInsets.only(right: 15),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: InputDecoration(
                          labelText: "验证码",
                        ),
                        onChanged: (value) {
                          registerPageModel.setVerifyCode = value;
                        },
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "${registerPageModel.getCodeButtonLabel}",
                        style: TextStyle(
                            color: registerPageModel.verifying
                                ? Colors.grey
                                : Colors.white),
                      ),
                      onPressed: registerPageModel.verifying
                          ? null
                          : () async {
                              MyLoading.eject();
                              try {
                                await registerPageModel.sendVerifyCode();
                              } catch (e) {
                                print(e);
                              } finally {
                                MyLoading.shut();
                              }
                            },
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
                TextField(
                  obscureText: registerPageModel.nonePassword,
                  onChanged: (value) {
                    registerPageModel.setPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: "登录密码",
                    hintText: "由8到16位的字母和数字组成",
                    suffixIcon: IconButton(
                      icon: Icon(registerPageModel.nonePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        registerPageModel.setNonePassword =
                            !registerPageModel.nonePassword;
                      },
                    ),
                  ),
                ),
                TextField(
                  obscureText: registerPageModel.noneAgainPassword,
                  onChanged: (value) {
                    registerPageModel.setAgainPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: "确认密码",
                    suffixIcon: IconButton(
                      icon: Icon(registerPageModel.noneAgainPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        registerPageModel.setNoneAgainPassword =
                            !registerPageModel.noneAgainPassword;
                      },
                    ),
                  ),
                ),
                Consumer2<UserInfoModel, ConfigModel>(
                  builder: (BuildContext context, UserInfoModel userInfoModel,
                      ConfigModel configModel, _) {
                    return RaisedButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Text(
                          "注册",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      color: Theme.of(context).accentColor,
                      onPressed: () async {
                        if (!configModel.agreeAllAgreement) {
                          MyToast.showToast(
                              msg: "您必须同意协议,才能进行账号注册",
                              gravity: ToastGravity.CENTER);
                          return;
                        }

                        MyLoading.eject();
                        try {
                          UserInfo userInfo =
                              await registerPageModel.registerAccounts();
                          if (userInfo.user_token.length == USER_TOKEN_LENGTH) {
                            //更新全局UserModel
                            await userInfoModel.userLogonSuccess(
                                userInfo: userInfo);
                            MyLoading.shut();
                            //跳转主页
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/main?currentIndex=$HOME_INDEX',
                                (route) => route == null);
                          } else {
                            MyLoading.shut();
                          }
                        } catch (e) {
                          print(e);
                          MyLoading.shut();
                        }
                      },
                    );
                  },
                ), //注册按钮
                Row(
                  children: <Widget>[
                    Consumer<ConfigModel>(
                      builder:
                          (BuildContext context, ConfigModel configModel, _) {
                        return Checkbox(
                          onChanged: (bool value) {
                            if (value) {
                              configModel.agreeAgreementFunction();
                            } else {
                              configModel.notAgreeAgreementFunction();
                            }
                          },
                          value: configModel.agreeAllAgreement,
                        );
                      },
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SMALL_FONT_SIZE,
                      ),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "我已经阅读并同意"),
                        TextSpan(
                          text: "《用户协议》",
                          style: TextStyle(color: Colors.blue),
                          recognizer: _recognizerUser,
                        ),
                        TextSpan(text: "和"),
                        TextSpan(
                          text: "《隐私政策》",
                          style: TextStyle(color: Colors.blue),
                          recognizer: _recognizerPrivacy,
                        ),
                      ])),
                    ),
                  ],
                ), //用户协议
              ],
            );
          },
        ),
      ),
    );
  }
}
