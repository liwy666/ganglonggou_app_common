import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/page/carts_page/components/cart_card.dart';
import 'package:flutter_app/page/carts_page/components/carts_page_bottom.dart';
import 'package:flutter_app/page/carts_page/components/carts_page_head.dart';
import 'package:flutter_app/page/carts_page/components/without_carts.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartsPage extends StatelessWidget {
  final bool showHead;

  CartsPage({@required this.showHead});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: MyTabBar(
        tabBarName: "购物车",
      ),
      body: CartsPageMain(
        showHead: showHead,
      ),
    );
  }
}

class CartsPageMain extends StatelessWidget {
  final double containerPadding = ScreenUtil().setWidth(50);

  final bool showHead;

  CartsPageMain({@required this.showHead});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        showHead
            ? Positioned(
                top: 0,
                child: CartsPageHead(
                  containerPadding: containerPadding,
                ),
              )
            : Container(),
        CustomScrollView(
          slivers: <Widget>[
            SliverPadding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil().setWidth(120),
                  top: showHead
                      ? this.containerPadding + ScreenUtil().setWidth(70)
                      : 0),
              sliver: Consumer<CartDataModel>(
                builder:
                    (BuildContext context, CartDataModel cartDataModel, _) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return cartDataModel.cartList.length < 1
                          ? WithoutCarts()
                          : CartCard(
                              cartItem: cartDataModel.cartList[index],
                              cartDataModel: cartDataModel,
                            );
                    },
                        childCount: cartDataModel.cartList.length < 1
                            ? 1
                            : cartDataModel.cartList.length),
                  );
                },
              ),
            )
          ],
        ),
        Positioned(
          bottom: 0,
          child: CartsPageBottom(),
        ),
      ],
    );
  }
}
