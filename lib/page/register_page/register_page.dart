import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/register_page_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Consumer<UserInfoModel>(
                  builder:
                      (BuildContext context, UserInfoModel userInfoModel, _) {
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
                    Checkbox(
                      onChanged: (bool value) {},
                      value: true,
                    ),
                    Text("我已阅读并同意"),
                    Text(
                      "《岗隆用户协议》",
                      style: TextStyle(color: Colors.blue),
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
