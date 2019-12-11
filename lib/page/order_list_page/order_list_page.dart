import 'package:flutter/material.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/order_data_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/data_model/user_info_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/models/orderPreviewItem.dart';
import 'package:flutter_app/page/components/my_page_tips.dart';
import 'package:flutter_app/page/components/my_tab_bar.dart';
import 'package:flutter_app/page/order_list_page/companents/preview_order_card.dart';
import 'package:flutter_app/page/order_list_page/companents/wait_evaluate_goods_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OrderListPage extends StatefulWidget {
  final String watchType;
  int _initialIndex;

  OrderListPage({Key key, @required this.watchType}) : super(key: key) {
    switch (watchType) {
      case "all":
        _initialIndex = 0;
        break;
      case "waitPay":
        _initialIndex = 1;
        break;
      case "waitSgin":
        _initialIndex = 2;
        break;
      case "waitEvaluate":
        _initialIndex = 3;
        break;
      case "afterSale":
        _initialIndex = 4;
        break;
      default:
        _initialIndex = 0;
    }
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _OrderListPage();
  }
}

class _OrderListPage extends State<OrderListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(
        vsync: this, length: 5, initialIndex: widget._initialIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: _themeModel.pageBackgroundColor1,
      appBar: AppBar(
        title: Text(
          "订单管理",
          style: TextStyle(
              color: Colors.white, fontSize: ScreenUtil().setWidth(28)),
        ),
        leading: LeftIcon(color: Colors.white),
//        iconTheme: ThemeData.estimateBrightnessForColor(Colors.white),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          unselectedLabelColor: _themeModel.pageBackgroundColor2,
          labelColor: _themeModel.pageBackgroundColor2,
          tabs: <Widget>[
            Tab(text: '全部订单'),
            Tab(text: '待付款'),
            Tab(text: '待收货'),
            Tab(text: '待评价'),
            Tab(text: '退货/售后'),
          ],
        ),
      ),
      body: Consumer2<OrderDataModel, UserInfoModel>(
        builder: (BuildContext context, OrderDataModel orderDataModel,
            UserInfoModel userInfoModel, _) {
          return TabBarView(
            controller: _tabController,
            children: <Widget>[
              _OrderListPageViewItem(
                children: orderDataModel.allOrder
                    .map<Widget>((OrderPreviewItem orderPreviewItem) {
                  return PreviewOrderCard(
                    orderPreviewItem: orderPreviewItem,
                  );
                }).toList(),
                onRefreshFunction: orderDataModel.reFresh,
                userToken: userInfoModel.userInfo.user_token,
              ),
              _OrderListPageViewItem(
                children: orderDataModel.waitPayOrder
                    .map<Widget>((OrderPreviewItem orderPreviewItem) {
                  return PreviewOrderCard(
                    orderPreviewItem: orderPreviewItem,
                  );
                }).toList(),
                onRefreshFunction: orderDataModel.reFresh,
                userToken: userInfoModel.userInfo.user_token,
              ),
              _OrderListPageViewItem(
                children: orderDataModel.waitSignOrder
                    .map<Widget>((OrderPreviewItem orderPreviewItem) {
                  return PreviewOrderCard(
                    orderPreviewItem: orderPreviewItem,
                  );
                }).toList(),
                onRefreshFunction: orderDataModel.reFresh,
                userToken: userInfoModel.userInfo.user_token,
              ),
              _OrderListPageViewItem(
                children: orderDataModel.waitEvaluateGoods
                    .map<Widget>((MidOrderItem midOrderItem) {
                  return WaitEvaluateGoodsCard(
                    midOrderItem: midOrderItem,
                  );
                }).toList(),
                onRefreshFunction: orderDataModel.reFresh,
                userToken: userInfoModel.userInfo.user_token,
              ),
              _OrderListPageViewItem(
                children: orderDataModel.afterSaleOrder
                    .map<Widget>((OrderPreviewItem orderPreviewItem) {
                  return PreviewOrderCard(
                    orderPreviewItem: orderPreviewItem,
                  );
                }).toList(),
                onRefreshFunction: orderDataModel.reFresh,
                userToken: userInfoModel.userInfo.user_token,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OrderListPageViewItem extends StatelessWidget {
  final List<Widget> children;
  final Future<dynamic> Function(String) onRefreshFunction;
  final String userToken;

  const _OrderListPageViewItem({
    Key key,
    @required this.children,
    @required this.onRefreshFunction,
    @required this.userToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
        child: ListView(
          children: children.length > 0
              ? children
              : [
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: MyPageTips(
                      imgRoute: 'static_images/without_order.png',
                      title: "您还没有相关订单",
                    ),
                  ),
                ],
        ),
        onRefresh: () async {
          await onRefreshFunction(userToken);
        }); //下拉刷新组件
  }
}
