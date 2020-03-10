import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/address_list_model.dart';
import 'package:ganglong_shop_app/data_model/cart_data_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/data_model/write_order_page_model.dart';
import 'package:ganglong_shop_app/page/components/my_count_down.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_address.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_bottom_button.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_coupon.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_goods_list.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_integral.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_invoice.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_list.dart';
import 'package:ganglong_shop_app/page/write_order_page/components/write_order_pay_type.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class WriteOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer3<AddressListModel, UserInfoModel, CartDataModel>(
      builder: (BuildContext context, AddressListModel addressListModel,
          UserInfoModel userInfoModel, CartDataModel cartDataModel, _) {
        return ProviderWidget<WriteOrderPageModel>(
          model: WriteOrderPageModel(),
          child: SliverList(
            delegate: SliverChildListDelegate([
              WriteOrderAddress(),
              WriteOrderGoodsList(),
              WriteOrderPayType(),
              WriteOrderInvoice(),
              WriteOrderCoupon(),
              //WriteOrderIntegral(),
              WriteOrderList(),
              Container(
                height: ScreenUtil().setWidth(MY_BOTTOM_BUTTON_HEIGHT),
              ),
            ]),
          ),
          onWidgetReady: (WriteOrderPageModel writeOrderPageModel) async {
            MyLoading.eject();
            try {
              await addressListModel.init(
                  userToken: userInfoModel.userInfo.user_token);
              await writeOrderPageModel.getPayType(
                  userToken: userInfoModel.userInfo.user_token);
              await writeOrderPageModel.getCouponList(
                  userToken: userInfoModel.userInfo.user_token);
              writeOrderPageModel.init(
                  cartDataModel: cartDataModel,
                  userInfo: userInfoModel.userInfo);
              MyLoading.shut();
            } catch (e) {
              MyLoading.shut();
              throw Exception(e);
            }
          },
          builder: (BuildContext context,
              WriteOrderPageModel writeOrderPageModel, Widget child) {
            final _themeModel = Provider.of<ThemeModel>(context);
            return Scaffold(
              backgroundColor: _themeModel.pageBackgroundColor1,
              appBar: MyTabBar(
                tabBarName: "填写订单",
              ),
              body: Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      child,
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: WriteOrderBottomButton(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
