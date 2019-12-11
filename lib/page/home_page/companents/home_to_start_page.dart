import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/page/components/my_dialog.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:provider/provider.dart';

class HomeToStartPage extends StatelessWidget {
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
              "去启动页",
              style: TextStyle(color: Theme.of(context).accentColor),
            ),
            shape: StadiumBorder(
                side: new BorderSide(
              style: BorderStyle.none,
            )),
            //color: Colors.red,
            onPressed: () {
              Application.router.navigateTo(context, '/start');
            },
          );
        },
      ),
    );
  }
}
