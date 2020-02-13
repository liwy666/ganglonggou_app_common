import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/models/goodsCouponItem.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';
import 'package:ganglong_shop_app/page/goods_page/components/goods_coupon_dialog.dart';
import 'package:ganglong_shop_app/page/goods_page/components/shop_promise_dialog.dart';

class CouponPreview extends StatelessWidget {
  final GoodsModel goodsModel;

  CouponPreview({@required this.goodsModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return goodsModel.loadFinish &&
            goodsModel.extraGoodsInfo.coupon_list.length > 0
        ? MyListTile(
            titleWidget: Text('领券'),
            subtitleWidget: Wrap(
                spacing: 1.0, // 主轴(水平)方向间距
                //runSpacing: 1.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.start,
                //沿主轴方向居中
                children: goodsModel.extraGoodsInfo.coupon_list
                    .map((GoodsCouponItem item) {
                  return Chip(
                    avatar: new CircleAvatar(
                        backgroundColor: Colors.red, child: Text('券')),
                    label: new Text(item.coupon_name),
                  );
                }).toList()),
            onTapFunction: () {
              MyDialog().showBottomDialog(
                  context: context, child: GoodsCouponDialog(), title: "用券更便宜");
            },
          )
        : Container();
  }
}
