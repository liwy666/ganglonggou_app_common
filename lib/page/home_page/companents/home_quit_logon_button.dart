import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:provider/provider.dart';

class HomeQuitLogonButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Consumer<UserInfoModel>(
        builder: (BuildContext context, UserInfoModel userInfoModel, _) {
          return FlatButton(
            color: _themeModel.pageBackgroundColor2,
            child: Text(
              "退出登录",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            shape: StadiumBorder(
                side: new BorderSide(
              style: BorderStyle.none,
            )),
            //color: Colors.red,
            onPressed: () {
              MyDialog().showConfirmDialog(
                  context: context,
                  title: "确认退出登录？",
                  clickFun: () async {
                    MyLoading.eject();
                    try {
                      await userInfoModel.retireLogon();
                      MyLoading.shut();
                    } catch (e) {
                      print(e);
                      MyLoading.shut();
                    }
                  },
                  cancelButtonText: "取消",
                  confirmButtonText: "确认");
            },
          );
        },
      ),
    );
  }
}
