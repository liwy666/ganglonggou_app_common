import 'package:extended_image/extended_image.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/goodsItem.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoodsItemComponent extends StatelessWidget {
  final GoodsItem item;

  GoodsItemComponent({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: ScreenUtil().setWidth(10),
              horizontal: ScreenUtil().setWidth(20)),
          color: Colors.white,
          child: Column(
            children: <Widget>[
              MyExtendedImage.network(
                item.goods_img,
                fit: BoxFit.fitWidth,
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setWidth(300),
              ),
              Container(
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Text(
                  item.goods_name,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
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
