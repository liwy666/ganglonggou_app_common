import 'package:fake_wechat/fake_wechat.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_list_data_model.dart';
import 'package:flutter_app/data_model/goods_model.dart';
import 'package:flutter_app/data_model/page_position_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/page/goods_page/components/bottm_button.dart';
import 'package:flutter_app/page/goods_page/components/goods_top_swiper.dart';
import 'package:flutter_app/page/goods_page/components/preview_supplier.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:provider/provider.dart';
import 'components/coupon_preview.dart';
import 'components/evaluate_preview.dart';
import 'components/goods_details.dart';
import 'components/goods_sku_preview.dart';
import 'components/shop_promise_preview.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class GoodsPage extends StatelessWidget {
  final int goodsId;
  bool initPagePosition = true;

  GoodsPage({@required this.goodsId});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    GoodsListDataModel goodsListModel =
        Provider.of<GoodsListDataModel>(context);
    // TODO: implement build
    return Consumer<UserInfoModel>(
      builder: (BuildContext context, UserInfoModel userInfoModel, _) {
        return ProviderWidget2<GoodsModel, PagePositionModel>(
          model1: GoodsModel(
              goodsList: goodsListModel.goodsList,
              goodsId: this.goodsId,
              userInfoModel: userInfoModel,
              pageContext: context),
          model2:
              PagePositionModel(monitoringPageHeightPositionMaxPosition: 300),
          child: GoodsDetails(), //商品详情,
          builder: ((BuildContext context, GoodsModel goodsModel,
              PagePositionModel pagePositionModel, Widget _child) {
            return Scaffold(
              backgroundColor: _themeModel.pageBackgroundColor1,
              body: Stack(
                children: <Widget>[
                  CustomScrollView(
                    controller: pagePositionModel.controller,
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        backgroundColor: _themeModel.pageBackgroundColor2,
                        leading: _LeftIcon(),
                        actions: [
                          _RightIcon(),
                        ],
                        title: Text(
                          "商品详情",
                          style: TextStyle(
                              fontSize: COMMON_FONT_SIZE,
                              color: _themeModel.fontColor1),
                        ),
                        centerTitle: true,
                        expandedHeight: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).padding.top,
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            height: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(0),
                            color: Colors.white,
                            child: goodsModel.loadFinish
                                ? GoodsTopSwiper()
                                : MyExtendedImage.network(
                                    goodsModel.goodsInfo.goodsImg,
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            child: Text(
                              "￥${goodsModel.goodsInfo.goodsPrice.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: BEST_LARGE_FONT_SIZE,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            color: _themeModel.pageBackgroundColor2,
                          ), //商品价格
                          Container(
                            child: Text(
                              goodsModel.goodsInfo.goodsName,
                              style: TextStyle(
                                  fontSize: LARGE_FONT_SIZE,
                                  fontWeight: FontWeight.w800,
                                  color: _themeModel.fontColor1),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            color: _themeModel.pageBackgroundColor2,
                          ), //商品名称
                          DefaultTextStyle(
                            style: TextStyle(fontSize: COMMON_FONT_SIZE),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              color: _themeModel.pageBackgroundColor2,
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    color: _themeModel.fontColor2,
                                    fontSize: SMALL_FONT_SIZE),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "快递：免邮费",
                                    ),
                                    Text(
                                        "库存：${goodsModel.goodsInfo.goodsStock}"),
                                    Text(
                                        "销量：${goodsModel.goodsInfo.goodsSalesVolume}"),
                                  ],
                                ),
                              ),
                            ),
                          ), //商品销量
                          CouponPreview(
                            goodsModel: goodsModel,
                          ), //优惠券
                          GoodsSkuPreview(
                            goodsModel: goodsModel,
                          ), //规格选择
                          ShopPromisePreview(), //购物保证
                          EvaluatePreview(
                            goodsModel: goodsModel,
                          ), //评价缩略,
                          PreviewSupplier(goodsModel: goodsModel), //供应商预览
                          Container(
                            color: _themeModel.pageBackgroundColor2,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              "图文介绍",
                              style: TextStyle(
                                  fontSize: COMMON_FONT_SIZE,
                                  color: Colors.blue),
                              textAlign: TextAlign.center,
                            ),
                          ) //商品详情框
                        ]),
                      ),
                      _child,
                    ],
                  ),
                  //GoodsTabBar(),
                  goodsModel.loadFinish
                      ? Positioned(
                          bottom: 0,
                          child: BottomButton(),
                        )
                      : Container(),
                ],
              ),
              floatingActionButtonLocation: _MyFloatingActionButtonLocation(),
              floatingActionButton: pagePositionModel.showToTopBtn
                  ? FloatingActionButton(
                      heroTag: "goods_page",
                      child: pagePositionModel.floatingActionButtonChild,
                      foregroundColor: _themeModel.pageBackgroundColor2,
                      hoverElevation: 300,
                      onPressed: () {
                        pagePositionModel.toTop();
                      },
                    )
                  : null,
            );
          }),
        );
      },
    );
  }
}

class _LeftIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      //color: Color.fromRGBO(255, 255, 255, 0.5),
      shape: CircleBorder(),
      child: Icon(
        Icons.keyboard_arrow_left,
        color: Colors.blueAccent,
      ),
      onPressed: () {
        Application.router.pop(context);
      },
    );
  }
}

class _RightIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsModel>(
      builder: (BuildContext context, GoodsModel goodsModel, _) {
        return PopupMenuButton(
          icon: Icon(
            Icons.share,
            color: Colors.blue,
          ),
          itemBuilder: (BuildContext context) {
            return <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: Image.asset(
                    "static_images/wechat_friend_logo.png",
                  ),
                  title: Text(
                    '微信好友',
                    style: TextStyle(fontSize: COMMON_FONT_SIZE),
                  ),
                ),
                value: "shareWeChatFriend",
              ),
              PopupMenuItem<String>(
                child: ListTile(
                  contentPadding: EdgeInsets.all(5),
                  leading: Image.asset(
                    "static_images/wechat_friend_circle_logo.png",
                  ),
                  title:
                      Text('朋友圈', style: TextStyle(fontSize: COMMON_FONT_SIZE)),
                ),
                value: "shareWeChatFriendCircle",
              ),
            ];
          },
          onSelected: (String action) {
            switch (action) {
              case "shareWeChatFriend":
                goodsModel.shareWeChatFriend(WechatScene.SESSION);
                break;
              case "shareWeChatFriendCircle":
                goodsModel.shareWeChatFriend(WechatScene.TIMELINE);
                break;
            }
          },
        );
      },
    );
  }
}

class _MyFloatingActionButtonLocation extends FloatingActionButtonLocation {
  const _MyFloatingActionButtonLocation();

  double getDockedY(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double contentBottom = scaffoldGeometry.contentBottom;
    final double bottomSheetHeight = scaffoldGeometry.bottomSheetSize.height;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double snackBarHeight = scaffoldGeometry.snackBarSize.height;

    double fabY = contentBottom - fabHeight / 2.0;
    // The FAB should sit with a margin between it and the snack bar.
    if (snackBarHeight > 0.0)
      fabY = math.min(
          fabY,
          contentBottom -
              snackBarHeight -
              fabHeight -
              kFloatingActionButtonMargin);
    // The FAB should sit with its center in front of the top of the bottom sheet.
    if (bottomSheetHeight > 0.0)
      fabY =
          math.min(fabY, contentBottom - bottomSheetHeight - fabHeight / 2.0);

    final double maxFabY = scaffoldGeometry.scaffoldSize.height - fabHeight;
    return math.min(maxFabY, fabY);
  }

  double _leftOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    return kFloatingActionButtonMargin +
        scaffoldGeometry.minInsets.left -
        offset;
  }

  double _rightOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    return scaffoldGeometry.scaffoldSize.width -
        kFloatingActionButtonMargin -
        scaffoldGeometry.minInsets.right -
        scaffoldGeometry.floatingActionButtonSize.width +
        offset;
  }

  double _endOffset(ScaffoldPrelayoutGeometry scaffoldGeometry,
      {double offset = 0.0}) {
    assert(scaffoldGeometry.textDirection != null);
    switch (scaffoldGeometry.textDirection) {
      case TextDirection.rtl:
        return _leftOffset(scaffoldGeometry, offset: offset);
      case TextDirection.ltr:
        return _rightOffset(scaffoldGeometry, offset: offset);
    }
    return null;
  }

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabX = _endOffset(scaffoldGeometry);
    return Offset(fabX, getDockedY(scaffoldGeometry) - 80);
  }

  @override
  String toString() => 'FloatingActionButtonLocation.startTop';
}
