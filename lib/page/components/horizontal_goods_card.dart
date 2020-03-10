import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HorizontalGoodsCard extends StatelessWidget {
  final int goodsId;
  final String goodsName;
  final String goodsImg;
  final String goodsAttribute;
  final double price;
  final int goodsNumber;
  final double width = 600;
  final double imgWidth = 180;

  HorizontalGoodsCard(
      {this.goodsId,
      @required this.goodsName,
      @required this.goodsImg,
      @required this.goodsAttribute,
      this.price,
      this.goodsNumber});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(width),
      height: ScreenUtil().setHeight(imgWidth),
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: MyExtendedImage.network(
              goodsImg,
              width: ScreenUtil().setWidth(imgWidth),
              height: ScreenUtil().setWidth(imgWidth),
              fit: BoxFit.contain,
            ),
            onTap: () {
              if (goodsId != null) {
                Application.router
                    .navigateTo(context, '/goods?goodsId=$goodsId');
              }
            },
          ),
          Container(
            width: ScreenUtil().setWidth(width - imgWidth),
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    '$goodsName  ${goodsNumber != null ? '×$goodsNumber' : ""}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: SMALL_FONT_SIZE,
                        fontWeight: FontWeight.w500,
                        color: _themeModel.fontColor1),
                  ),
                  onTap: () {
                    if (goodsId != null) {
                      Application.router
                          .navigateTo(context, '/goods?goodsId=$goodsId');
                    }
                  },
                ),
                Text(
                  goodsAttribute,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: SO_SMALL_FONT_SIZE,
                      color: _themeModel.fontColor2),
                ),
                price == null
                    ? Container()
                    : Text(
                        "￥${price.toStringAsFixed(2)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: SMALL_FONT_SIZE,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
