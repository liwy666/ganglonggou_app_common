import 'dart:convert';
import 'dart:ui';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/addressItem.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressCard extends StatelessWidget {
  final AddressItem addressItem;
  final Function switchDefaultFunction;
  final String intoUrl;

  const AddressCard(
      {Key key,
      @required this.addressItem,
      @required this.switchDefaultFunction,
      @required this.intoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Card(
      child: Container(
        color: _themeModel.pageBackgroundColor2,
        padding: EdgeInsets.symmetric(
            vertical: ScreenUtil().setWidth(15), horizontal: 10),
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Row(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(80),
                    height: ScreenUtil().setWidth(80),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: addressItem.is_default == 1
                            ? Theme.of(context).accentColor
                            : Colors.grey),
                    child: Center(
                      child: Text(
                        "${addressItem.name.substring(0, 1)}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setWidth(35)),
                      ),
                    ),
                  ),
                  DefaultTextStyle(
                    style: TextStyle(color: Colors.black54),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "姓名：${addressItem.name}",
                            style: TextStyle(fontSize: SMALL_FONT_SIZE),
                          ),
                          Text(
                            "手机号：${addressItem.tel}",
                            style: TextStyle(fontSize: SMALL_FONT_SIZE),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(500),
                            child: Text(
                              "地址：${addressItem.province}${addressItem.city}${addressItem.county}${addressItem.address_detail}",
                              style: TextStyle(fontSize: SMALL_FONT_SIZE),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                switchDefaultFunction();
              },
            ),
            GestureDetector(
              child: Text(
                "编辑",
                style: TextStyle(
                    color: Colors.blue, fontSize: ScreenUtil().setWidth(24)),
              ),
              onTap: () {
                //print(utf8.decode(base64Decode(code)));
                Application.router.navigateTo(context,
                    '/edit_address?addressItemJson=${base64UrlEncode(utf8.encode(jsonEncode(addressItem.toJson())))}&editType=update&intoUrl=${intoUrl.substring(1)}');
              },
            )
          ],
        ),
      ),
    );
  }
}
