import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/register_page_model.dart';
import 'package:ganglong_shop_app/data_model/retrieve_password_page_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RetrievePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyTabBar(
        tabBarName: '找回密码',
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(50),
            horizontal: ScreenUtil().setWidth(40)),
        child: ProviderWidget<RetrievePasswordPageModel>(
          model: RetrievePasswordPageModel(),
          builder: (BuildContext context,
              RetrievePasswordPageModel retrievePasswordPageModel, _) {
            return ListView(
              //runSpacing: 20.0, // 纵轴（垂直）方向间距
              children: <Widget>[
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    retrievePasswordPageModel.setEmailAddress = value;
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
                          retrievePasswordPageModel.setVerifyCode = value;
                        },
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "${retrievePasswordPageModel.getCodeButtonLabel}",
                        style: TextStyle(
                            color: retrievePasswordPageModel.verifying
                                ? Colors.grey
                                : Colors.white),
                      ),
                      onPressed: retrievePasswordPageModel.verifying
                          ? null
                          : () async {
                              MyLoading.eject();
                              try {
                                await retrievePasswordPageModel
                                    .sendVerifyCode();
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
                  obscureText: retrievePasswordPageModel.nonePassword,
                  onChanged: (value) {
                    retrievePasswordPageModel.setPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: "新的登录密码",
                    hintText: "由8到16位的字母和数字组成",
                    suffixIcon: IconButton(
                      icon: Icon(retrievePasswordPageModel.nonePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        retrievePasswordPageModel.setNonePassword =
                            !retrievePasswordPageModel.nonePassword;
                      },
                    ),
                  ),
                ),
                TextField(
                  obscureText: retrievePasswordPageModel.noneAgainPassword,
                  onChanged: (value) {
                    retrievePasswordPageModel.setAgainPassword = value;
                  },
                  decoration: InputDecoration(
                    labelText: "确认密码",
                    suffixIcon: IconButton(
                      icon: Icon(retrievePasswordPageModel.noneAgainPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        retrievePasswordPageModel.setNoneAgainPassword =
                            !retrievePasswordPageModel.noneAgainPassword;
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
                          "提交",
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
                          UserInfo userInfo = await retrievePasswordPageModel
                              .registerAccounts();
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
              ],
            );
          },
        ),
      ),
    );
  }
}
