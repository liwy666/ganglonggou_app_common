import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/horizontal_goods_card.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PreviewOrderCard extends StatelessWidget {
  final OrderPreviewItem orderPreviewItem;

  const PreviewOrderCard({Key key, @required this.orderPreviewItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Card(
      child: Container(
        color: _themeModel.pageBackgroundColor2,
        padding: EdgeInsets.only(top: 5, left: 0, right: 0, bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: ScreenUtil().setWidth(40),
              //color: Theme.of(context).accentColor,
              child: Text(
                "订单号:${orderPreviewItem.order_sn}",
                style: TextStyle(
                  color:_themeModel.fontColor2,
                  fontSize: ScreenUtil().setWidth(24),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: ScreenUtil().setWidth(60),
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  "${orderPreviewItem.order_state_name}",
                  style: TextStyle(
                    color: _themeModel.pageBackgroundColor2,
                    fontSize: ScreenUtil().setWidth(24),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Column(
              children:
                  orderPreviewItem.mid_order.map((MidOrderItem midOrderItem) {
                return HorizontalGoodsCard(
                  goodsAttribute: midOrderItem.sku_desc,
                  goodsNumber: midOrderItem.goods_number,
                  goodsName: midOrderItem.goods_name,
                  goodsImg: midOrderItem.img_url,
                  price: double.parse(midOrderItem.mid_order_price),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "查看详情",
                      style: TextStyle(color: _themeModel.pageBackgroundColor2),
                    ),
                    shape: StadiumBorder(
                        side: new BorderSide(
                      style: BorderStyle.none,
                    )),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      Application.router.navigateTo(context,
                          '/read_order?orderSn=${orderPreviewItem.order_sn}');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
