import 'dart:convert';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/page/components/my_bottom_button.dart';
import 'package:flutter_app/page/components/my_dialog.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/goods_page/components/goods_sku_dialog.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyBottomButton(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  Application.router.navigateTo(context, '/carts');
                },
                constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.shopping_cart,
                          color: Colors.blue, size: LARGE_FONT_SIZE),
                      Text("购物车",
                          style: TextStyle(
                              fontSize: SO_SMALL_FONT_SIZE,
                              color: Colors.grey,
                              fontWeight: FontWeight.w100))
                    ],
                  ),
                ),
              ),
              RawMaterialButton(
                  onPressed: () {
                    Application.router.navigateTo(context,
                        '/web_view?initialLink=${base64UrlEncode(utf8.encode(CONTACT_CUSTOMER_SERVICE_URL))}');
                  },
                  constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.group,
                            color: Colors.blue, size: LARGE_FONT_SIZE),
                        Text("在线客服",
                            style: TextStyle(
                                fontSize: SO_SMALL_FONT_SIZE,
                                color: Colors.grey))
                      ],
                    ),
                  )),
              RawMaterialButton(
                  onPressed: () async{
                    MyLoading.eject();
                    await launch("tel:$CONTACT_CUSTOMER_SERVICE_TElPHONE_NUMBER");
                    MyLoading.shut();
                  },
                  constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Colors.blue,
                          size: LARGE_FONT_SIZE,
                        ),
                        Text("电话客服",
                            style: TextStyle(
                                fontSize: SO_SMALL_FONT_SIZE,
                                color: Colors.grey))
                      ],
                    ),
                  )),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    MyDialog()
                      ..showBottomDialog(
                          context: context,
                          child: GoodsSkuDiaLog(
                            clickType: SkuButtonClickType.addShoppingCart,
                          ));
                  },
                  color: Colors.red,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.29,
                    height:
                        ScreenUtil().setWidth(MY_BOTTOM_BUTTON_HEIGHT) * 0.8,
                    child: Center(
                      child: Text(
                        "加入购物车",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: SMALL_FONT_SIZE),
                      ),
                    ),
                  )),
              RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    MyDialog()
                      ..showBottomDialog(
                          context: context,
                          child: GoodsSkuDiaLog(
                            clickType: SkuButtonClickType.immediateBuy,
                          ));
                  },
                  color: Colors.orange,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.29,
                    height:
                        ScreenUtil().setWidth(MY_BOTTOM_BUTTON_HEIGHT) * 0.8,
                    child: Center(
                      child: Text(
                        "立即购买",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white, fontSize: SMALL_FONT_SIZE),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    ));
  }
}
