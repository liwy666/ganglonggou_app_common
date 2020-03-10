import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/getVersionInfo.dart';
import 'package:provider/provider.dart';

class IfUpdateDialogBoxChild extends StatelessWidget {
  final GetVersionInfo getVersionInfo;
  final Function immediateUpdate;

  const IfUpdateDialogBoxChild(
      {Key key, @required this.getVersionInfo, @required this.immediateUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: _themeModel.pageBackgroundColor2,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'static_images/update_img.png',
                fit: BoxFit.fitWidth,
              ), //头图
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "发现新版本",
                      style: TextStyle(
                          fontSize: LARGE_FONT_SIZE,
                          fontWeight: FontWeight.w600,
                          color: _themeModel.fontColor1),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: _themeModel.themeColor,
                        ),
                        child: Text("V${getVersionInfo.app_version}",
                            style: TextStyle(
                                fontSize: LARGE_FONT_SIZE,
                                fontWeight: FontWeight.w600,
                                color: _themeModel.pageBackgroundColor2))),
                  ],
                ),
              ), //标题
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: DefaultTextStyle(
                  style: TextStyle(
                      color: _themeModel.fontColor2,
                      fontSize: COMMON_FONT_SIZE,
                      height: 1.7),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getVersionInfo.describe
                          .split("|")
                          .map<Widget>((String str) {
                        return Text(str);
                      }).toList()),
                ),
              ), //更新版本说明
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      "取消",
                      style: TextStyle(
                          color: _themeModel.fontColor2,
                          fontSize: LARGE_FONT_SIZE),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      "立即更新",
                      style: TextStyle(
                          color: _themeModel.themeColor,
                          fontSize: LARGE_FONT_SIZE),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      immediateUpdate();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
