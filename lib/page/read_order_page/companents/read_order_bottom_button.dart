import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/data_model/read_order_page_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/data_model/write_order_page_model.dart';
import 'package:flutter_app/page/components/my_bottom_button.dart';
import 'package:flutter_app/page/components/my_dialog.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/post_write_order.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReadOrderBottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyBottomButton(
      child: Consumer<ReadOrderPageModel>(
        builder:
            (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _Button(
                buttonColor: Colors.white,
                buttonText: "取消订单",
                textColor: Theme.of(context).accentColor,
                onPressedFunction: () {
                  MyDialog().showConfirmDialog(
                      context: context,
                      title: "确认要取消订单吗？",
                      clickFun: () {
                        readOrderPageModel.orderCancel();
                      },
                      cancelButtonText: "我再想想",
                      confirmButtonText: "确认");
                },
                isShow: readOrderPageModel.orderInfo.order_state == 1,
              ),
              _Button(
                buttonColor: Colors.red,
                buttonText: "删除订单",
                onPressedFunction: () {
                  MyDialog().showConfirmDialog(
                      context: context,
                      title: "确认要删除订单吗？",
                      clickFun: () async {
                        await readOrderPageModel.orderDelete();
                        Application.router.pop(context);
                      },
                      cancelButtonText: "我再想想",
                      confirmButtonText: "确认");
                },
                isShow: readOrderPageModel.orderInfo.order_state == 0,
              ),
              _Button(
                buttonColor: Theme.of(context).accentColor,
                buttonText: "立即支付",
                onPressedFunction: () {
                  readOrderPageModel.orderPayment();
                },
                isShow: readOrderPageModel.orderInfo.order_state == 1,
              ),
              _Button(
                buttonColor: Theme.of(context).accentColor,
                buttonText: "确认收货",
                onPressedFunction: () {
                  readOrderPageModel.orderTake();
                },
                isShow: readOrderPageModel.orderInfo.order_state == 3,
              ),
              _Button(
                buttonColor: Theme.of(context).accentColor,
                buttonText: "取消申请",
                onPressedFunction: () {
                  MyDialog().showConfirmDialog(
                      context: context,
                      title: "确认要取消售后申请吗？",
                      clickFun: () {
                        readOrderPageModel.cancelAfterService();
                      },
                      cancelButtonText: "我再想想",
                      confirmButtonText: "确认");
                },
                isShow: readOrderPageModel.orderInfo.order_state == 6,
              ),
              _Button(
                buttonColor: Colors.white,
                buttonText: "申请售后",
                textColor: Theme.of(context).accentColor,
                onPressedFunction: () {
                  Application.router.navigateTo(context,
                      '/ask_after_service?orderSn=${readOrderPageModel.orderSn}');
                },
                isShow: readOrderPageModel.orderInfo.order_state == 2 ||
                    readOrderPageModel.orderInfo.order_state == 4,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final Color buttonColor;
  final Function onPressedFunction;
  final Color textColor;
  final String buttonText;
  final bool isShow;

  const _Button(
      {Key key,
      @required this.buttonColor,
      @required this.onPressedFunction,
      this.textColor = Colors.white,
      @required this.buttonText,
      @required this.isShow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: isShow
          ? RaisedButton(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor),
              ),
              shape: StadiumBorder(
                  side: new BorderSide(
                style: BorderStyle.none,
              )),
              color: buttonColor,
              onPressed: () {
                onPressedFunction();
              },
            )
          : Container(),
    );
  }
}
