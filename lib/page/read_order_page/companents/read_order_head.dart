import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/read_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_count_down.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:provider/provider.dart';

class ReadOrderHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return readOrderPageModel.orderInfo.order_state == 1
            ? MyCountDown(
                endTime: readOrderPageModel.orderInfo.invalid_pay_time,
                title: "等待付款，超出时效订单将自动关闭",
              )
            : _ReadOrderHeadMain(
                orderStateCode: readOrderPageModel.orderInfo.order_state,
                orderState: readOrderPageModel.orderInfo.order_state_name,
              );
      },
    );
  }
}

class _ReadOrderHeadMain extends StatelessWidget {
  final int orderStateCode;
  final String orderState;

  const _ReadOrderHeadMain(
      {Key key, @required this.orderStateCode, @required this.orderState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery.of(context).size.width,
      //height: 50,
      padding: EdgeInsets.only(top: 15, bottom: 20),
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.red, Colors.orange[700]]), //背景渐变
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          MyExtendedImage.asset("static_images/order_state_$orderStateCode.png",
              width: LARGE_FONT_SIZE, fit: BoxFit.fitWidth),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              orderState,
              style: TextStyle(color: Colors.white, fontSize: LARGE_FONT_SIZE),
            ),
          )
        ],
      ),
    );
  }
}
