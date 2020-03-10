import 'package:flutter/gestures.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/logon_data_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/logon_page/components/logon_logon_button.dart';
import 'package:ganglong_shop_app/page/logon_page/components/logon_other_logon_button.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LogonPage extends StatelessWidget {
  final bool showBar;
  final TapGestureRecognizer _recognizerUser = TapGestureRecognizer();
  final TapGestureRecognizer _recognizerPrivacy = TapGestureRecognizer();

  LogonPage({Key key, this.showBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _recognizerUser.onTap = () {
      openUserAgreement(context);
    };
    _recognizerPrivacy.onTap = () {
      openPrivacyAgreement(context);
    };
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return ProviderWidget<LogonDataModel>(
          model: LogonDataModel(
              pageContext: context, userInfoModel: userInfoModel),
          child: MyTabBar(
            hideLeftButton: showBar == true ? false : true,
            tabBarName: "登录",
          ),
          builder: (BuildContext context, LogonDataModel logonDataModel,
              Widget child) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: child,
              body: Container(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setWidth(50),
                    horizontal: ScreenUtil().setWidth(40)),
                child: Wrap(
                  runSpacing: 20.0, // 纵轴（垂直）方向间距
                  children: <Widget>[
                    Text("岗隆帐号登录",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenUtil().setWidth(22))),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        logonDataModel.setEmailAddress = value;
                      },
                      decoration: InputDecoration(
                        labelText: "请输入邮箱号",
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "请输入密码",
                      ),
                      onChanged: (value) {
                        logonDataModel.setPassword = value;
                      },
                    ),
                    LoGonLoGonButton(), //登录按钮
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          child: Text(
                            "忘记密码？",
                            style: TextStyle(
                                fontSize: ScreenUtil().setWidth(20),
                                color: Colors.black),
                          ),
                          onTap: () {
                            Application.router
                                .navigateTo(context, '/retrieve_password');
                          },
                        ),
                        GestureDetector(
                          child: Text(
                            "帐号注册",
                            style: TextStyle(
                                fontSize: ScreenUtil().setWidth(20),
                                color: Colors.black),
                          ),
                          onTap: () {
                            Application.router.navigateTo(context, '/register');
                          },
                        ),
                      ],
                    ), //（忘记密码、注册）
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SMALL_FONT_SIZE,
                      ),
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "登录即代表您已同意"),
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
                    LogonOtherLogonButton(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
