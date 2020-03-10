import 'package:flutter/services.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/read_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_order_list.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:provider/provider.dart';

class ReadOrderDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return MyOrderList(
          children: [
            MyOderListItem(
              label: "订单编号",
              value: Row(
                children: <Widget>[
                  Text("${readOrderPageModel.orderInfo.order_sn}"),
                  IconButton(
                    icon: Text(
                      "复制",
                      style: TextStyle(
                          color: Colors.blue, fontSize: SO_SMALL_FONT_SIZE),
                    ),
                    onPressed: () async {
                      ClipboardData data = new ClipboardData(
                          text: readOrderPageModel.orderInfo.order_sn);
                      await Clipboard.setData(data);
                      MyToast.showToast(msg: "已复制到您的剪切板"); //短提示
                    },
                  ),
                ],
              ),
            ),
            MyOderListItem(
              label: "订单状态",
              value: Text("${readOrderPageModel.orderInfo.order_state_name}"),
            ),
            MyOderListItem(
              label: "支付方式",
              value: Text(
                  "${readOrderPageModel.orderInfo.pay_name}${readOrderPageModel.orderInfo.bystages_val}"),
            ),
            MyOderListItem(
              label: "下单时间",
              value: Text("${readOrderPageModel.orderInfo.create_time}"),
            ),
            MyOderListItem(
              label: "支付时间",
              value: Text(
                  "${readOrderPageModel.orderInfo.pay_time == null || readOrderPageModel.orderInfo.pay_time.isEmpty ? "" : readOrderPageModel.orderInfo.pay_time}"),
            ),
            MyOderListItem(
              label: "商家提醒",
              value: Text(
                  "${readOrderPageModel.orderInfo.order_visible_note == null || readOrderPageModel.orderInfo.order_visible_note.isEmpty ? "" : readOrderPageModel.orderInfo.order_visible_note}"),
            ),
            MyOderListItem(
              label: "订单总金额",
              value:
                  Text("￥${readOrderPageModel.orderInfo.original_order_price}"),
            ),
            MyOderListItem(
              label: "使用优惠券减免",
              value: Text(
                  "￥${double.parse(readOrderPageModel.orderInfo.after_using_coupon_price) - double.parse(readOrderPageModel.orderInfo.original_order_price)}"),
            ),
            MyOderListItem(
              label: "使用积分减免",
              value: Text(
                  "￥${double.parse(readOrderPageModel.orderInfo.after_using_coupon_price) - double.parse(readOrderPageModel.orderInfo.after_using_integral_price)}"),
            ),
            MyOderListItem(
              label: "支付方式减免",
              value: Text(
                  "￥${double.parse(readOrderPageModel.orderInfo.after_using_pay_price) - double.parse(readOrderPageModel.orderInfo.after_using_integral_price)}"),
            ),
            MyOderListItem(
              label: "结算金额",
              value: Text(
                "￥${readOrderPageModel.orderInfo.order_price}",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
