import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../my_extended_image.dart';

class MyGoodsListCard extends StatelessWidget {
  final GoodsItem item;
  final int index;

  MyGoodsListCard({Key key, @required this.item, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(
            left: index % 2 == 0 ? 10 : 0, right: index % 2 == 0 ? 0 : 10),
        color: _themeModel.pageBackgroundColor2,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: MyExtendedImage.network(
                  item.goods_img,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  item.goods_name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _themeModel.fontColor1,
                    fontSize: SMALL_FONT_SIZE,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setHeight(15)),
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Text(
                    "￥${item.shop_price}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: COMMON_FONT_SIZE,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                  constraints: BoxConstraints(
                    minWidth: double.infinity,
                  ),
                  child: Text(
                    "￥${item.market_price}",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SMALL_FONT_SIZE,
                        decoration: TextDecoration.lineThrough),
                  )),
            ],
          ),
        ),
      ),
      onTap: () {
        Application.router
            .navigateTo(context, '/goods?goodsId=${item.goods_id}');
      },
    );
  }
}
