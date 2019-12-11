import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/data_model/order_data_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/data_model/write_order_page_model.dart';
import 'package:flutter_app/page/components/my_bottom_button.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/post_write_order.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderBottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyBottomButton(
      child: Consumer4<WriteOrderPageModel, UserInfoModel, CartDataModel,
          OrderDataModel>(
        builder: (BuildContext context,
            WriteOrderPageModel writeOrderPageModel,
            UserInfoModel userInfoModel,
            CartDataModel cartDataModel,
            OrderDataModel orderDataModel,
            _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text.rich(TextSpan(
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: ScreenUtil().setWidth(36),
                        fontWeight: FontWeight.w800),
                    children: [
                      TextSpan(
                          text: "￥",
                          style:
                              TextStyle(fontSize: ScreenUtil().setWidth(24))),
                      TextSpan(
                          text:
                              "${writeOrderPageModel.orderPrice.toStringAsFixed(2)}"),
                    ])),
                FlatButton(
                  child: Text(
                    "提交订单",
                    style: TextStyle(color: Colors.white),
                  ),
                  shape: StadiumBorder(
                      side: new BorderSide(
                    style: BorderStyle.none,
                  )),
                  color: Theme.of(context).accentColor,
                  onPressed: () async {
                    MyLoading.eject();
                    String orderSn = "";
                    try {
                      orderSn = await writeOrderPageModel
                          .submitOrder(userInfoModel.userInfo.user_token);
                      if (orderSn.length == ORDER_SN_LENGTH) {
                        //更新用户信息
                        await userInfoModel.reFreshUserInfo();
                        //删除购物车
                        await cartDataModel.delCart();
                        //更新订单
                        await orderDataModel
                            .reFresh(userInfoModel.userInfo.user_token);
                        //关闭加载等待
                        MyLoading.shut();
                        //跳转订单详情页面
                        Navigator.popAndPushNamed(
                            context, '/read_order?orderSn=$orderSn');
                      }
                    } catch (e) {
                      print("订单提交发送错误:${e.toString()}");
                      MyLoading.shut();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
