import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/page/components/my_bottom_button.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartsPageBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyBottomButton(
      child: Consumer<CartDataModel>(
        builder: (BuildContext context, CartDataModel cartDataModel, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Checkbox(
                    value: cartDataModel.allChoice,
                    onChanged: (_) {
                      cartDataModel.switchAllChoice();
                    },
                  ),
                  Text(
                    "全选",
                    style: TextStyle(fontSize: ScreenUtil().setWidth(20)),
                  ),
                  cartDataModel.selectionCartList.length > 0
                      ? Container(
                          margin: EdgeInsets.only(left: 15),
                          child: GestureDetector(
                            child: Text(
                              "删除选中",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setWidth(20),
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              MyDialog().showConfirmDialog(
                                  context: context,
                                  title:
                                      "确认要删除这${cartDataModel.selectionCartList.length}种商品吗？",
                                  clickFun: cartDataModel.delCart,
                                  cancelButtonText: "我再想想",
                                  confirmButtonText: "删除");
                            },
                          ),
                        )
                      : Container()
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "合计:",
                    style: TextStyle(fontSize: ScreenUtil().setWidth(26)),
                  ),
                  Text(
                    "￥${cartDataModel.selectionCartListAllPrice}",
                    style: TextStyle(
                        fontSize: ScreenUtil().setWidth(22), color: Colors.red),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Consumer<UserInfoModel>(
                      builder: (BuildContext context,
                          UserInfoModel userInfoModel, _) {
                        return FlatButton(
                          child: Text(
                            "去结算",
                            style: TextStyle(color: Colors.white),
                          ),
                          shape: StadiumBorder(
                              side: new BorderSide(
                            style: BorderStyle.none,
                          )),
                          color: Theme.of(context).accentColor,
                          onPressed: () async {
                            if (userInfoModel.isLogon) {
                              bool result =
                                  await cartDataModel.settlementCarts(context);
                              if (result) {
                                Application.router
                                    .navigateTo(context, '/write_order');
                              }
                            } else {
                              Application.router
                                  .navigateTo(context, '/logon?showBar=true');
                            }
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
