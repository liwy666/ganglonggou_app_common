import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/order_data_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_single_row_tile.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return Container(
          color: _themeModel.pageBackgroundColor2,
          //margin: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
          child: Column(
            children: <Widget>[
              MySingleRowTile(
                child: Text(
                  "查看全部",
                  style: TextStyle(fontSize: COMMON_FONT_SIZE),
                ),
                onTapFunction: () {
                  if (!userInfoModel.isLogon) {
                    Application.router
                        .navigateTo(context, "/logon?showBar=true");
                    return;
                  }
                  Application.router.navigateTo(context, '/order_list');
                },
                rightIcon: Icon(
                  Icons.description,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Consumer<OrderDataModel>(
                  builder:
                      (BuildContext context, OrderDataModel orderDataModel, _) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        _HomeOrderItem(
                          iconData: Icons.monetization_on,
                          title: "待付款",
                          orderNumber: orderDataModel.waitPayOrder.length,
                          isLogon: userInfoModel.isLogon,
                        ),
                        _HomeOrderItem(
                          iconData: Icons.airport_shuttle,
                          title: "待收货",
                          orderNumber: orderDataModel.waitSignOrder.length,
                          isLogon: userInfoModel.isLogon,
                        ),
                        _HomeOrderItem(
                          iconData: Icons.chat,
                          title: "待评价",
                          orderNumber: orderDataModel.waitEvaluateGoods.length,
                          isLogon: userInfoModel.isLogon,
                        ),
                        _HomeOrderItem(
                          iconData: Icons.access_time,
                          title: "退货/售后",
                          orderNumber: orderDataModel.afterSaleOrder.length,
                          isLogon: userInfoModel.isLogon,
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _HomeOrderItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final int orderNumber;
  final bool isLogon;

  const _HomeOrderItem(
      {Key key,
      @required this.iconData,
      @required this.title,
      @required this.orderNumber,
      @required this.isLogon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final _themeModel = Provider.of<ThemeModel>(context);
    return FlatButton(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                iconData,
                color: _themeModel.fontColor2,
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                child: Text(
                  title,
                  style: TextStyle(
                      color: _themeModel.fontColor1, fontSize: SMALL_FONT_SIZE),
                ),
              ),
            ],
          ),
          orderNumber == 0
              ? Container()
              : Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    color: Theme.of(context).accentColor,
                    height: ScreenUtil().setWidth(25),
                    width: ScreenUtil().setWidth(25),
                    child: Center(
                      child: Text(
                        "$orderNumber",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setWidth(18),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
      onPressed: () {
        if (!isLogon) {
          Application.router.navigateTo(context, "/logon?showBar=true");
          return;
        }

        switch (title) {
          case "待付款":
            Application.router
                .navigateTo(context, '/order_list?watchType=waitPay');
            break;
          case "待收货":
            Application.router
                .navigateTo(context, '/order_list?watchType=waitSgin');
            break;
          case "待评价":
            Application.router
                .navigateTo(context, '/order_list?watchType=waitEvaluate');
            break;
          case "退货/售后":
            Application.router
                .navigateTo(context, '/order_list?watchType=afterSale');
            break;
          default:
            Application.router.navigateTo(context, '/order_list?watchType=all');
        }
      },
    );
  }
}
