import 'package:extended_image/extended_image.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/logon_data_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LogonPage extends StatelessWidget {
  final bool showBar;

  const LogonPage({Key key, this.showBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    _LogonButton(),
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
                    ),
                    Row(
                      children: <Widget>[
                        Text("第三方帐号登录",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: ScreenUtil().setWidth(22))),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Wrap(
                        children: <Widget>[
                          FlatButton(
                            child: Container(
                              width: ScreenUtil().setWidth(80),
                              height: ScreenUtil().setWidth(80),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(40)),
                              child: ExtendedImage.asset(
                                "static_images/wechat_logo_black.png",
                                width: ScreenUtil().setWidth(80),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            onPressed: () {
                              logonDataModel.weChatLogon();
                            }, // ,
                          ), //微信
                          FlatButton(
                            child: Container(
                              width: ScreenUtil().setWidth(80),
                              height: ScreenUtil().setWidth(80),
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius: BorderRadius.circular(40)),
                              child: ExtendedImage.asset(
                                "static_images/alpay_logo_black.png",
                                width: ScreenUtil().setWidth(80),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            onPressed: () {
                              logonDataModel.aliApyLogon();
                            },
                          ), //支付宝
                        ],
                      ),
                    ),
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

class _LogonButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<LogonDataModel, UserInfoModel>(
      builder: (BuildContext context, LogonDataModel logonDataModel,
          UserInfoModel userInfoModel, Widget _) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            child: Text(
              "登 录",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            MyLoading.eject();
            try {
              //登录
              UserInfo userInfo = await logonDataModel.logon();
              if (userInfo.user_token.length == USER_TOKEN_LENGTH) {
                //更新全局UserModel
                await userInfoModel.userLogonSuccess(userInfo: userInfo);
                MyLoading.shut();
                //跳转主页
                Navigator.of(context)
                    .pushReplacementNamed('/main?currentIndex=$HOME_INDEX');
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
    );
  }
}
