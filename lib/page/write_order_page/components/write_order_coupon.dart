import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_coupon_open.dart';
import 'package:provider/provider.dart';

class WriteOrderCoupon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<WriteOrderPageModel>(
      builder:
          (BuildContext context, WriteOrderPageModel writeOrderPageModel, _) {
        return MyListTile(
          titleWidget: Text("优惠券"),
          subtitleWidget:
              Text("${writeOrderPageModel.allowCouponList.length}张可用"),
          onTapFunction: () {
            if (writeOrderPageModel.allowCouponList.length > 0) {
              MyDialog().showBottomDialog(
                  context: context,
                  child: WriteOrderCouponOpen(),
                  title: "优惠券选择");
            }
          },
        );
      },
    );
  }
}
