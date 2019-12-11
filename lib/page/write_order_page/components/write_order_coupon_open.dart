import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/write_order_page_model.dart';
import 'package:flutter_app/models/couponItem.dart';
import 'package:flutter_app/page/components/my_coupon_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderCouponOpen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(top: 40, left: 15, right: 15),
      height: ScreenUtil().setWidth(900),
      child: Consumer<WriteOrderPageModel>(
        builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
            Widget child) {
          return ListView(
            children: _getCouponCardList(writeOrderPageModel),
          );
        },
      ),
    );
  }

  List<Widget> _getCouponCardList(WriteOrderPageModel writeOrderPageModel) {
    List<Widget> couponCardList = writeOrderPageModel.allowCouponList
        .map<Widget>((CouponItem couponItem) {
      return Container(
        margin: EdgeInsets.only(top:15),
        child: Stack(
          children: <Widget>[
            MyCouponCard(
              couponId: couponItem.coupon_id,
              couponDesc: couponItem.coupon_desc,
              couponName: couponItem.coupon_name,
              foundSum: double.parse(couponItem.found_sum),
              cutSum: double.parse(couponItem.cut_sum),
              startUseTime: couponItem.start_use_time,
              endUseTime: couponItem.end_use_time,
            ),
            Positioned(
                right: 15,
                child: Checkbox(
                  onChanged: (_) {
                    /*  cartDataModel.switchCartChoiceState(
                  choiceState: value, cartInfo: cartItem);*/
                    writeOrderPageModel.switchCoupon(couponItem.coupon_id);
                  },
                  value:
                  writeOrderPageModel.choiceCouponId == couponItem.coupon_id
                      ? true
                      : false,
                )),
          ],
        ),
      );
    }).toList();

    return couponCardList;
  }
}
