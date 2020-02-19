import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_test.dart';
import 'package:provider/provider.dart';

class HomeTestButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child:FlatButton(
        color: _themeModel.pageBackgroundColor2,
        child: Text(
          "测试",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        shape: StadiumBorder(
            side: new BorderSide(
              style: BorderStyle.none,
            )),
        //color: Colors.red,
        onPressed: () async{
          MyLoading.eject();
          await FetchTest.fetch();
          MyLoading.shut();
        },
      ),
    );
  }
}
