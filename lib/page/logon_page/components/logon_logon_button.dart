import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/config_model.dart';
import 'package:ganglong_shop_app/data_model/logon_data_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/userInfo.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:provider/provider.dart';

class LoGonLoGonButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer3<LogonDataModel, UserInfoModel, ConfigModel>(
      builder: (BuildContext context, LogonDataModel logonDataModel,
          UserInfoModel userInfoModel, ConfigModel configModel, Widget _) {
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
    );;
  }

}