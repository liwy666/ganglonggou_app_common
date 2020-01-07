import 'package:extended_image/extended_image.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/attributeValueItem.dart';
import 'package:flutter_app/models/goodsInfo.dart';
import 'package:flutter_app/models/goodsSkuOptionsItem.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/page/components/my_options_align.dart';
import 'package:flutter_app/page/components/my_stepper.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

enum SkuButtonClickType {
  addShoppingCart,
  immediateBuy,
}

class GoodsSkuDiaLog extends StatelessWidget {
  final SkuButtonClickType clickType;

  GoodsSkuDiaLog({@required this.clickType});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      child: Consumer<GoodsModel>(
        builder: (BuildContext context, GoodsModel goodsModel, _) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: MyExtendedImage.network(
                      goodsModel.goodsInfo.goodsAttributeImg,
                      fit: BoxFit.fitWidth,
                    ),
                  ), //属性图片
                  Container(
                    height: MediaQuery.of(context).size.width * 0.35,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "￥${goodsModel.goodsInfo.goodsPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                              fontSize: SO_LARGE_FONT_SIZE,
                              fontWeight: FontWeight.w900,
                              color: Colors.red),
                        ),
                        Text(
                          "商品编号：${goodsModel.goodsInfo.goodsSn}",
                          style: TextStyle(
                              fontSize: SO_SMALL_FONT_SIZE,
                              color: _themeModel.fontColor1),
                        ),
                        Text(
                          "库存：${goodsModel.goodsInfo.goodsStock.toString()}",
                          style: TextStyle(
                              fontSize: SO_SMALL_FONT_SIZE,
                              color: _themeModel.fontColor1),
                        ),
                      ],
                    ),
                  ), //商品编号，库存 //
                ],
              ), //sku头部
              Container(
                  height: ScreenUtil().setWidth(650),
                  child: ListView(
                    children: goodsModel.goodsSkuOptions
                        .map((GoodsSkuOptionsItem item) {
                      return _SkuOptionsAlign(
                        goodsSkuOptionsItem: item,
                        skuOptionsAlignIndex:
                            goodsModel.goodsSkuOptions.indexOf(item),
                        goodsModel: goodsModel,
                      );
                    }).toList(),
                  ) //sku选项,
                  ), //sku选项
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "数量:",
                      style: TextStyle(
                          fontSize: COMMON_FONT_SIZE,
                          color: _themeModel.fontColor1),
                    ),
                    MyStepper(
                      value: goodsModel.goodsInfo.goodsNumber,
                      min: 1,
                      max: goodsModel.goodsInfo.goodsStock,
                      changeFunction: goodsModel.updGoodsInfoNumber,
                    ),
                  ],
                ),
              ), //数量
              Container(
                child: Consumer2<CartDataModel, UserInfoModel>(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Text(
                      goodsModel.goodsInfo.goodsStock <
                              goodsModel.goodsInfo.goodsNumber
                          ? "库存不足"
                          : "确定",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setWidth(24),
                      ),
                    ),
                  ),
                  builder: (BuildContext context, CartDataModel cartDataModel,
                      UserInfoModel userInfoModel, Widget child) {
                    return RaisedButton(
                      onPressed: goodsModel.goodsInfo.goodsStock <
                              goodsModel.goodsInfo.goodsNumber
                          ? null
                          : () {
                              buttonOnClick(
                                  goodsInfo: goodsModel.goodsInfo,
                                  cartDataModel: cartDataModel,
                                  userInfoModel: userInfoModel,
                                  goodsPageContext: goodsModel.pageContext,
                                  context: context);
                              //Navigator.of(context).pop();
                            },
                      color: Colors.red,
                      shape: StadiumBorder(
                          side: new BorderSide(
                        style: BorderStyle.none,
                      )),
                      child: child,
                    );
                  },
                ),
              ), //按钮,
            ],
          );
        },
      ),
    );
  }

  /*确定按钮点击*/
  void buttonOnClick(
      {@required GoodsInfo goodsInfo,
      @required CartDataModel cartDataModel,
      @required UserInfoModel userInfoModel,
      @required BuildContext goodsPageContext,
      @required BuildContext context}) {
    Navigator.of(context).pop();
    if (!userInfoModel.isLogon) {
      Application.router.navigateTo(goodsPageContext, '/logon?showBar=true');
      return;
    }

    if (this.clickType == SkuButtonClickType.addShoppingCart) {
      this.addShoppingCart(goodsInfo: goodsInfo, cartDataModel: cartDataModel);
    } else if (this.clickType == SkuButtonClickType.immediateBuy) {
      this.immediateBuy(
          goodsInfo: goodsInfo, cartDataModel: cartDataModel, context: context);
    }
  }

  ///加入购物车事件
  void addShoppingCart(
      {@required GoodsInfo goodsInfo, @required CartDataModel cartDataModel}) {
    cartDataModel.addCart(goodsInfo: goodsInfo);
  }

  ///立即购买事件
  void immediateBuy(
      {@required GoodsInfo goodsInfo,
      @required CartDataModel cartDataModel,
      @required BuildContext context}) {
    cartDataModel.immediateBuy(goodsInfo: goodsInfo, context: context);
  }
}

class _SkuOptionsAlign extends StatelessWidget {
  final GoodsSkuOptionsItem goodsSkuOptionsItem;
  final int skuOptionsAlignIndex;
  final GoodsModel goodsModel;

  _SkuOptionsAlign(
      {@required this.goodsSkuOptionsItem,
      @required this.skuOptionsAlignIndex,
      @required this.goodsModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyOptionsAlign(
      itemList: goodsSkuOptionsItem.attributeValue
          .map((AttributeValueItem attributeValueItem) {
        return MyOptionsAlignItem(
          isChoice: attributeValueItem.choiceFlag,
          itemValue: attributeValueItem.name,
          onTap: () {
            goodsModel.switchGoodsSku(
                skuOptionsAlignIndex: skuOptionsAlignIndex,
                skuOptionItemIndex: goodsModel
                    .goodsSkuOptions[skuOptionsAlignIndex].attributeValue
                    .indexOf(attributeValueItem));
          },
        );
      }).toList(),
      title: this.goodsSkuOptionsItem.attributeName,
    );
  }
}
