import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/models/goodsCouponItem.dart';
import 'package:flutter_app/page/components/my_list_tile.dart';

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
            onTapFunction: () {},
          )
        : Container();
  }
}
