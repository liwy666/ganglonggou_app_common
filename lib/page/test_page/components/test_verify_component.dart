import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

class TestVerifyComponent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestVerifyComponent();
  }
}

class _TestVerifyComponent extends State<TestVerifyComponent> {
  String authCode = "";
  String truthAuthCode = DEBUG ? "" : "ganglong88888888";
  String errorText;

  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.4,
      color: themeModel.pageBackgroundColor2,
      child: ListView(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            child: MyExtendedImage.asset('static_images/test_into.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 25),
            child: TextField(
                //cursorColor: Colors.blue,
                decoration: InputDecoration(
                  errorText: errorText,
                  hintText: "输入您的邀请码",
                ),
                onChanged: (String val) {
                  this.authCode = val;
                },
                onEditingComplete: () {
                  _verify();
                }),
          ),
          FlatButton(
            shape: StadiumBorder(
                side: new BorderSide(
              style: BorderStyle.none,
            )),
            color: themeModel.themeColor,
            child: Text(
              "进入",
              style: TextStyle(color: themeModel.pageBackgroundColor2),
            ),
            onPressed: () {
              _verify();
            },
          )
        ],
      ),
    );
  }

  void _verify() {
    if (authCode != truthAuthCode) {
      setState(() {
        errorText = "邀请码输入错误";
        authCode = "";
      });
    } else {
      Application.router.pop(context);
      Application.router.navigateTo(context, '/test');
    }
  }
}
