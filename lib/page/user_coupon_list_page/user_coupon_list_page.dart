import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_coupon_list_page_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/couponItem.dart';
import 'package:flutter_app/page/components/my_coupon_card.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:provider/provider.dart';

class UserCouponListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: MyTabBar(
        tabBarName: '我的优惠券',
      ),
      body: Consumer<UserInfoModel>(
        builder: (BuildContext context, UserInfoModel userInfoModel, _) {
          return ProviderWidget<UserCouponListPageModel>(
            model: UserCouponListPageModel(),
            builder: (BuildContext context,
                UserCouponListPageModel userCouponListPageModel, _) {
              return userCouponListPageModel.couponItemList.length > 0
                  ? ListView(
                      children: userCouponListPageModel.couponItemList
                          .map<Widget>((CouponItem couponItem) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: MyCouponCard(
                            couponDesc: couponItem.coupon_desc,
                            cutSum: double.parse(couponItem.cut_sum),
                            couponName: couponItem.coupon_name,
                            couponId: couponItem.coupon_id,
                            foundSum: double.parse(couponItem.found_sum),
                            startUseTime: couponItem.start_use_time,
                            endUseTime: couponItem.end_use_time,
                          ),
                        );
                      }).toList(),
                    )
                  : Center(
                      child: Column(
                        children: <Widget>[
                          MyPageTips(
                            imgRoute: 'static_images/without_user_coupon.png',
                            title: "",
                          ),
                          RaisedButton(
                            child: Text(
                              "去领券中心",
                              style: TextStyle(color: Colors.white),
                            ),
                            shape: StadiumBorder(
                                side: new BorderSide(
                              style: BorderStyle.none,
                            )),
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              Application.router.navigateTo(context, "/coupon_list");
                            },
                          ), //操场按钮
                        ],
                      ),
                    );
            },
            onWidgetReady:
                (UserCouponListPageModel userCouponListPageModel) async {
              MyLoading.eject();
              try {
                await userCouponListPageModel
                    .init(userInfoModel.userInfo.user_token);
                MyLoading.shut();
              } catch (e) {
                print(e);
                MyLoading.shut();
              }
            },
          );
        },
      ),
    );
  }
}
