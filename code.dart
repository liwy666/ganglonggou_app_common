import 'dart:async';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class _CODE {
  ///关于ios
  /// fake_wechat
  /// flutter_webview_plugin

  BuildContext get context => null;

  /*常用组件*/
  _CODE() {
    final _themeModel = Provider.of<ThemeModel>(context);
    var editAddressPageModel;
    List<dynamic> codeWidget = [
      RaisedButton(
        child: Text(
          "退出登录",
          style: TextStyle(color: Colors.white),
        ),
        shape: StadiumBorder(
            side: new BorderSide(
          style: BorderStyle.none,
        )),
        color: Colors.red,
        onPressed: () {},
      ), //操场按钮

      GestureDetector(
        child: Card(),
        onTap: () {
          //Application.router.navigateTo(context, '/goods?goodsId=${item.goods_id}');
        },
      ), //点击事件组件

      RefreshIndicator(
        child: ListView(),
        onRefresh: () {
          return null;
        },
      ), //下拉刷新组件

      NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification &&
              notification.depth == 0 &&
              notification.metrics.pixels < 300) {}
          return true;
        },
        child: Container(),
      ), //滑动监听

      ProviderWidget<GoodsModel>(
        model: GoodsModel(),
        builder: ((BuildContext context, GoodsModel goodsModel, _) {
          return Container();
        }),
      ), //监听model

      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(0.0, -0.2),
              )
            ],
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      ), //卡片模拟

      /*   WidgetsBinding.instance.addPostFrameCallback((callback){
        print("complete");
      }),*/ //监听是否渲染完成

      Theme.of(context).accentColor, //获取主题颜色

      Fluttertoast.showToast(msg: "哎呀，库存不足了"), //短提示

      Navigator.of(context).pushNamedAndRemoveUntil(
          '/write_order', ModalRoute.withName('/')), //返回指定页面

      Navigator.popAndPushNamed(context, '/read_order'), //注销当前页面跳转

      TextField(
        controller: TextEditingController.fromValue(TextEditingValue(
            // 设置内容
            text: editAddressPageModel.addressItem.name,
            // 保持光标在最后
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: editAddressPageModel.addressItem.name.length)))),
        maxLength: 11,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(labelText: "收件人姓名"),
        onChanged: (val) {
          editAddressPageModel.setName = val;
        },
      ), //输入框、保持光标、默认值

      //确认对话框
      /* MyDialog().showConfirmDialog(
          context: context,
          title: "确认要删除这${cartDataModel.selectionCartList.length}种商品吗？",
          clickFun: cartDataModel.delCart,
          cancelButtonText: "我再想想",
          confirmButtonText: "删除"), */
    ];
  }

  /*常用方法*/
  way() {
    var now = new DateTime.now(); //获取当前日期
    var date = new DateTime.now().millisecondsSinceEpoch; //获取当前时间戳(ms)

    //模拟等待
    Future<void> _onRefresh() async {
      await Future.delayed(Duration(seconds: 3), () {});
    }

    //路由导航
    var Application;
    var context;
    var goodsItem;
    Application.router
        .navigateTo(context, '/goods?goodsId=${goodsItem.goods_id}');

    //计时器
    int i = 0;
    Timer timer;
    timer = Timer.periodic(Duration(milliseconds: 50), (timer1) {
      i++;
      print(i);
      if (i >= 300) {
        timer.cancel();
      }
    });
  }
}

class ThemeModel {}

class ProviderWidget<T> {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T model;
  final Widget child;
  final Function(T) onModelReady;

  ProviderWidget({
    Key key,
    this.builder,
    this.model,
    this.child,
    this.onModelReady,
  });
}

class GoodsModel {}
