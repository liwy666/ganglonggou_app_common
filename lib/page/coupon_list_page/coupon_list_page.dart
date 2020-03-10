import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/coupon_list_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/couponItem.dart';
import 'package:ganglong_shop_app/models/goodsCouponItem.dart';
import 'package:ganglong_shop_app/page/components/my_coupon_card.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_page_tips.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class CouponListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
        backgroundColor: _themeModel.pageBackgroundColor1,
        appBar: MyTabBar(
          tabBarName: "领券中心",
        ),
        body: Consumer<UserInfoModel>(
          builder: (BuildContext context, UserInfoModel userInfoModel, _) {
            return ProviderWidget<CouponListPageModel>(
              model: CouponListPageModel(
                  userInfoModel: userInfoModel, pageContext: context),
              onModelReady: (CouponListPageModel couponListPageModel) {
                couponListPageModel.init();
              },
              builder: (BuildContext context,
                  CouponListPageModel couponListPageModel, _) {
                return couponListPageModel.couponList.length > 0
                    ? ListView(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        children: couponListPageModel.couponList
                            .map((CouponItem goodsCouponItem) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              child: MyCouponCard(
                                cutSum: double.parse(goodsCouponItem.cut_sum),
                                couponDesc: goodsCouponItem.coupon_desc,
                                couponNumber: goodsCouponItem.coupon_number,
                                couponRemainderNumber:
                                    goodsCouponItem.coupon_remainder_number,
                                couponName: goodsCouponItem.coupon_name,
                                couponId: goodsCouponItem.coupon_id,
                                foundSum:
                                    double.parse(goodsCouponItem.found_sum),
                              ),
                            ),
                            onTap: () async {
                              MyLoading.eject();
                              try {
                                await couponListPageModel
                                    .userGetCoupon(goodsCouponItem.coupon_id);
                              } catch (e) {
                                print(e);
                              } finally {
                                MyLoading.shut();
                              }
                            },
                          );
                        }).toList(),
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Center(
                          child: MyPageTips(
                            imgRoute: "static_images/without_coupon.png",
                            title: "来晚了~~",
                          ),
                        ));
              },
            );
          },
        ));
  }
}
