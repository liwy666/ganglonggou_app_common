import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/models/goodsCouponItem.dart';
import 'package:ganglong_shop_app/page/components/my_coupon_card.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:provider/provider.dart';

class GoodsCouponDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsModel>(
      builder: (BuildContext context, GoodsModel goodsModel, _) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            children: goodsModel.extraGoodsInfo.coupon_list
                .map((GoodsCouponItem goodsCouponItem) {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: MyCouponCard(
                    cutSum: double.parse(goodsCouponItem.cut_sum),
                    couponDesc: goodsCouponItem.coupon_desc,
                    couponNumber: goodsCouponItem.coupon_number,
                    couponRemainderNumber:
                        goodsCouponItem.coupon_remainder_number,
                    couponName: goodsCouponItem.coupon_name,
                    couponId: goodsCouponItem.coupon_id,
                    foundSum: double.parse(goodsCouponItem.found_sum),
                  ),
                ),
                onTap: () async {
                  MyLoading.eject();
                  try {
                    await goodsModel.userGetCoupon(goodsCouponItem.coupon_id);
                  } catch (e) {
                    print(e);
                  } finally {
                    MyLoading.shut();
                  }
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
