import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class PreviewSupplier extends StatelessWidget {
  final GoodsModel goodsModel;

  PreviewSupplier({@required this.goodsModel});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return this.goodsModel.loadFinish
        ? Card(
            color: _themeModel.pageBackgroundColor2,
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MyExtendedImage.network(
                        goodsModel
                            .extraGoodsInfo.supplier_preview_info.logo_img,
                        width: ScreenUtil().setWidth(150),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            goodsModel.extraGoodsInfo.supplier_preview_info
                                .supplier_name,
                            style: TextStyle(
                                color: _themeModel.fontColor1,
                                fontWeight: FontWeight.w800,
                                fontSize: COMMON_FONT_SIZE),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Text(
                                goodsModel.extraGoodsInfo.supplier_preview_info
                                    .company_name,
                                style: TextStyle(
                                    color: _themeModel.fontColor1,
                                    fontSize: SMALL_FONT_SIZE)),
                          ),
                        ],
                      ),
                      RaisedButton(
                        child: Text(
                          "进店逛逛",
                          style: TextStyle(
                              color: _themeModel.pageBackgroundColor2,
                              fontSize: SMALL_FONT_SIZE),
                        ),
                        shape: StadiumBorder(
                            side: new BorderSide(
                          style: BorderStyle.none,
                        )),
                        color: Colors.red,
                        onPressed: () {
                          Map<String, dynamic> SupplierInfoMap = goodsModel
                              .extraGoodsInfo.supplier_preview_info
                              .toJson();
                          SupplierInfoMap['goods_list'] = null;
                          Application.router.navigateTo(context,
                              "/supplier?supplierPreviewInfoJson=${base64UrlEncode(utf8.encode(jsonEncode(SupplierInfoMap)))}");
                        },
                      )
                    ],
                  ),
                ), //头部
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: _themeModel.fontColor1,
                      fontSize: SMALL_FONT_SIZE,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text.rich(TextSpan(children: [
                          TextSpan(text: "宝贝描述:"),
                          TextSpan(
                              text: goodsModel.extraGoodsInfo
                                  .supplier_preview_info.describe_rate,
                              style: TextStyle(color: Colors.red)),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(text: "卖家服务:"),
                          TextSpan(
                              text: goodsModel.extraGoodsInfo
                                  .supplier_preview_info.service_rate,
                              style: TextStyle(color: Colors.red)),
                        ])),
                        Text.rich(TextSpan(children: [
                          TextSpan(text: "物流服务:"),
                          TextSpan(
                              text: goodsModel.extraGoodsInfo
                                  .supplier_preview_info.logistics_rate,
                              style: TextStyle(color: Colors.red)),
                        ])),
                      ],
                    ),
                  ),
                ), //评分
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "店铺推荐",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: ScreenUtil().setSp(24)),
                  ),
                ), //推荐标题
                Container(
                  child: Wrap(
                    children: goodsModel
                        .extraGoodsInfo.supplier_preview_info.goods_list
                        .map<Widget>((GoodsItem item) {
                      return _PreviewSupplierGoodsItem(
                        goodsItem: item,
                      );
                    }).toList(),
                  ),
                ), //推荐商品
              ],
            ),
          )
        : Container();
  }
}

class _PreviewSupplierGoodsItem extends StatelessWidget {
  final GoodsItem goodsItem;

  _PreviewSupplierGoodsItem({this.goodsItem});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    double itemWidth = MediaQuery.of(context).size.width / 3;
    // TODO: implement build
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        width: itemWidth,
        child: Column(
          children: <Widget>[
            MyExtendedImage.network(
              goodsItem.goods_img,
              width: itemWidth * 0.8,
              fit: BoxFit.fitWidth,
            ),
            Container(
              width: itemWidth,
              height: ScreenUtil().setWidth(60),
              margin: EdgeInsets.only(top: 5),
              child: Text(
                goodsItem.goods_name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _themeModel.fontColor1,
                  fontSize: SMALL_FONT_SIZE,
                ),
              ),
            ),
            Container(
              width: itemWidth,
              child: Text(
                "￥${goodsItem.shop_price}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w800,
                  fontSize: SMALL_FONT_SIZE,
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Application.router
            .navigateTo(context, '/goods?goodsId=${goodsItem.goods_id}');
      },
    );
  }
}
