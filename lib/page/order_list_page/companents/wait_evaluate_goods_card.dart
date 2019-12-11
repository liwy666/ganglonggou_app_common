import 'dart:convert';

import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/horizontal_goods_card.dart';
import 'package:flutter_app/routes/application.dart';

class WaitEvaluateGoodsCard extends StatelessWidget {
  final MidOrderItem midOrderItem;

  const WaitEvaluateGoodsCard({Key key, @required this.midOrderItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Container(
        padding: EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            HorizontalGoodsCard(
              goodsImg: midOrderItem.img_url,
              goodsName: midOrderItem.goods_name,
              goodsAttribute: midOrderItem.sku_desc,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    "评价",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: StadiumBorder(
                      side: new BorderSide(
                    style: BorderStyle.none,
                  )),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    String midOrderItemJson = jsonEncode(midOrderItem.toJson());
                    Application.router.navigateTo(context,
                        '/submit_evaluate?midOrderJson=${base64UrlEncode(utf8.encode(midOrderItemJson))}');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
