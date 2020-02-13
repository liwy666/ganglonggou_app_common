import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_order_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Consumer2<WriteOrderPageModel, CartDataModel>(
        builder: (BuildContext context, WriteOrderPageModel writeOrderPageModel,
            CartDataModel cartDataModel, _) {
          return MyOrderList(
            children: <MyOderListItem>[
              MyOderListItem(
                label: "订单总金额：",
                value: Text("￥${cartDataModel.selectionCartListAllPrice}"),
              ),
              MyOderListItem(
                label: "使用优惠券减免：",
                value: Text("-￥${writeOrderPageModel.couponPrice}"),
              ),
              MyOderListItem(
                label: "使用积分减免：",
                value: Text("-￥${writeOrderPageModel.integralPrice}"),
              ),
              MyOderListItem(
                label: "支付方式减免：",
                value: Text(
                    "-￥${writeOrderPageModel.payTypePrice.toStringAsFixed(2)}"),
              ),
              MyOderListItem(
                label: "结算金额：",
                value: Text(
                    "￥${writeOrderPageModel.orderPrice.toStringAsFixed(2)}"),
              ),
            ],
          );
        },
      ),
    );
  }
}
