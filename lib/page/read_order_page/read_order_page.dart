import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/order_data_model.dart';
import 'package:flutter_app/data_model/read_order_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/page/read_order_page/companents/read_order_address.dart';
import 'package:flutter_app/page/read_order_page/companents/read_order_bottom_button.dart';
import 'package:flutter_app/page/read_order_page/companents/read_order_details.dart';
import 'package:flutter_app/page/read_order_page/companents/read_order_goods_list.dart';
import 'package:flutter_app/page/read_order_page/companents/read_order_logistics.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'companents/read_order_head.dart';
import 'companents/read_order_invoice.dart';

class ReadOrderPage extends StatelessWidget {
  final String orderSn;

  const ReadOrderPage({Key key, @required this.orderSn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer2<UserInfoModel, OrderDataModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel,
          OrderDataModel orderDataModel, _) {
        return ProviderWidget<ReadOrderPageModel>(
          child: MyTabBar(
            tabBarName: "订单详情",
          ),
          model: ReadOrderPageModel(
              orderSn: orderSn,
              userToken: userInfoModel.userInfo.user_token,
              orderDataModel: orderDataModel),
          onWidgetReady: (ReadOrderPageModel readOrderPageModel) async {
            MyLoading.eject();
            try {
              await readOrderPageModel.init();
            } catch (e) {
              print(e);
            } finally {
              MyLoading.shut();
            }
          },
          builder: (BuildContext context, ReadOrderPageModel readOrderPageModel,
              Widget child) {
            final _themeModel = Provider.of<ThemeModel>(context);
            return Scaffold(
              backgroundColor: _themeModel.pageBackgroundColor1,
              appBar: child,
              body: Stack(
                children: <Widget>[
                  readOrderPageModel.loadingFinish
                      ? ListView(
                          children: <Widget>[
                            ReadOrderHead(),
                            ReadOrderAddress(),
                            ReadOrderGoodsList(),
                            ReadOrderDetails(),
                            ReadOrderInvoice(),
                            ReadOrderLogistics(),
                            Container(
                              height: ScreenUtil()
                                  .setWidth(MY_BOTTOM_BUTTON_HEIGHT),
                            ),
                          ],
                        )
                      : Container(),
                  Positioned(
                    bottom: 0,
                    child: readOrderPageModel.loadingFinish
                        ? ReadOrderBottomButton()
                        : Container(),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
