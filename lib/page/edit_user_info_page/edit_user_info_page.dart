import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/edit_user_info_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

class EditUserInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: '编辑资料',
      ),
      backgroundColor: _themeModel.pageBackgroundColor2,
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Consumer<UserInfoModel>(
            builder: (BuildContext context, UserInfoModel userInfoModel, _) {
              return ProviderWidget<EditUserInfoPageModel>(
                model: EditUserInfoPageModel(userInfo: userInfoModel.userInfo),
                builder: (BuildContext context,
                    EditUserInfoPageModel editUserInfoPageModel, _) {
                  return ListView(
                    children: <Widget>[
                      Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyExtendedImage.network(
                              editUserInfoPageModel.userInfo.user_img,
                              width: MediaQuery.of(context).size.width * 0.35,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "点我切换头像",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          onTap: () {
                            editUserInfoPageModel.uploadUserHeadPortrait();
                          },
                        ),
                      ),
                      TextField(
                        controller: TextEditingController.fromValue(
                            TextEditingValue(
                                // 设置内容
                                text: editUserInfoPageModel.userInfo.user_name,
                                // 保持光标在最后
                                selection: TextSelection.fromPosition(
                                    TextPosition(
                                        affinity: TextAffinity.downstream,
                                        offset: editUserInfoPageModel
                                            .userInfo.user_name.length)))),
                        onChanged: (value) {
                          editUserInfoPageModel.setUserName = value;
                        },
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: "$COMPANY_NAME_ABBREVIATION昵称",
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: RaisedButton(
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
                            bool submitResult =
                                await editUserInfoPageModel.submitUserData();
                            print(submitResult);
                            if (submitResult) {
                              MyLoading.eject();
                              await userInfoModel.updateUserInfo(
                                  editUserInfoPageModel.userInfo);
                              MyLoading.shut();
                              Application.router.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )),
    );
  }
}
