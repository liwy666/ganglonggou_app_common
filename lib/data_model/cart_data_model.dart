import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/models/goodsInfo.dart';
import 'package:flutter_app/page/components/my_loading.dart';
import 'package:flutter_app/request/post_check_carts.dart';
import 'package:flutter_app/routes/application.dart';
import 'package:flutter_app/sqflite_model/cart_sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartDataModel extends ChangeNotifier {
  List<CartItem> _cartList;
  List<CartItem> _selectionCartList;
  bool _allChoice = false;

  List<CartItem> get cartList => _cartList;

  List<CartItem> get selectionCartList => _selectionCartList;

  bool get allChoice => _allChoice;

  String get selectionCartListAllPrice => _getSelectionCartListAllPrice();

  int get selectionCartListAllIntegral => _getSelectionCartListAllIntegral();

  /*初始化*/
  void init({@required List<CartItem> cartList}) {
    _cartList = cartList;
    this._updateSelectionCartList();
  }

  /*更新选中购物车表单*/
  void _updateSelectionCartList() {
    _selectionCartList =
        _cartList.where((CartItem e) => (e.isChoice == 1)).toList();
  }

  /*更新cart数据库*/
  Future<void> _updateCartSql() async {
    await CartSqFlite().insertAllDate<CartItem>(this._cartList);
  }

  /*获取选中列表的价格总和*/
  String _getSelectionCartListAllPrice() {
    if (_selectionCartList.length == 0 || _selectionCartList == null)
      return 0.toRadixString(2);
    double price = 0;
    _selectionCartList.forEach((CartItem item) {
      price += item.goodsPrice;
    });

    return price.toStringAsFixed(2);
  }

  /*获取可使用积分总和*/
  int _getSelectionCartListAllIntegral() {
    if (_selectionCartList.length == 0 || _selectionCartList == null) return 0;
    int integral = 0;
    _selectionCartList.forEach((CartItem item) {
      integral += item.oneIntegral * item.goodsNumber;
    });
    return integral;
  }

  /*添加购物车*/
  Future<bool> addCart({@required GoodsInfo goodsInfo}) async {
    CartItem waitAddCartItem = CartItem.fromJson(goodsInfo.toJson());
    //设置默认为选中和有效
    waitAddCartItem.isChoice = 1;
    waitAddCartItem.isValid = 1;
    //判断购物车是否有这件商品
    CartItem whereCartItem = _cartList.firstWhere(
        (CartItem e) =>
            (e.goodsId == goodsInfo.goodsId && e.skuId == goodsInfo.skuId),
        orElse: () => (null));
    //如果没有这件商品就添加，如果有就更新数量
    if (whereCartItem == null) {
      _cartList.insert(0, waitAddCartItem);
    } else {
      //检查库存
      if (whereCartItem.goodsNumber + waitAddCartItem.goodsNumber >
          waitAddCartItem.goodsStock) {
        //提示用户库存不足
        Fluttertoast.showToast(msg: "哎呀，库存不足了");
        return false;
      }
      //更新数量和购物车价格
      whereCartItem.goodsNumber =
          whereCartItem.goodsNumber + waitAddCartItem.goodsNumber;
      whereCartItem.goodsPrice =
          whereCartItem.goodsNumber * whereCartItem.oneGoodsPrice;
      //获取索引并替换
      int whereCartItemIndex = _cartList.indexWhere((CartItem e) =>
          (e.goodsId == goodsInfo.goodsId && e.skuId == goodsInfo.skuId));
      _cartList[whereCartItemIndex] = whereCartItem;
    }

    //加载框
    MyLoading.eject();
    //更新选中列表
    this._updateSelectionCartList();
    //更新数据库
    await this._updateCartSql();
    //关闭加载
    MyLoading.shut();
    //通知用户添加成功
    Fluttertoast.showToast(msg: "已帮您将商品加入购物车");
    //通知更新
    notifyListeners();
    return true;
  }

  /*更新购物车数量*/
  Future<bool> updCartNumber(
      {@required int cartNumber, @required CartItem cartInfo}) async {
    CartItem whereCartItem = _cartList.firstWhere(
        (CartItem e) =>
            (e.goodsId == cartInfo.goodsId && e.skuId == cartInfo.skuId),
        orElse: () => (null));
    if (whereCartItem == null) return false;

    //更新数量和购物车价格
    whereCartItem.goodsNumber = cartNumber;
    whereCartItem.goodsPrice =
        whereCartItem.goodsNumber * whereCartItem.oneGoodsPrice;
    //获取索引并替换
    int whereCartItemIndex = _cartList.indexWhere((CartItem e) =>
        (e.goodsId == cartInfo.goodsId && e.skuId == cartInfo.skuId));
    _cartList[whereCartItemIndex] = whereCartItem;

    //更新数据
    //加载框
    MyLoading.eject();
    //更新选中列表
    this._updateSelectionCartList();
    //更新数据库
    await this._updateCartSql();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  /*切换选中*/
  Future<bool> switchCartChoiceState(
      {@required bool choiceState, @required CartItem cartInfo}) async {
    CartItem whereCartItem = _cartList.firstWhere(
        (CartItem e) =>
            (e.goodsId == cartInfo.goodsId && e.skuId == cartInfo.skuId),
        orElse: () => (null));
    if (whereCartItem == null) return false;
    whereCartItem.isChoice = choiceState ? 1 : 0;
    //获取索引并替换
    int whereCartItemIndex = _cartList.indexWhere((CartItem e) =>
        (e.goodsId == cartInfo.goodsId && e.skuId == cartInfo.skuId));
    _cartList[whereCartItemIndex] = whereCartItem;
    //更新数据
    //加载框
    MyLoading.eject();
    //更新选中列表
    this._updateSelectionCartList();
    //更新数据库
    await this._updateCartSql();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  /*全选*/
  Future<bool> switchAllChoice() async {
    if (_selectionCartList == null) return false;
    if (_selectionCartList.length < _cartList.length) {
      //全选
      for (int i = 0; i < _cartList.length; i++) {
        _cartList[i].isChoice = 1;
      }
      this._allChoice = true;
    } else {
      //全不选
      for (int i = 0; i < _cartList.length; i++) {
        _cartList[i].isChoice = 0;
      }
      this._allChoice = false;
    }
    //加载框
    MyLoading.eject();
    //更新选中列表
    this._updateSelectionCartList();
    //更新数据库
    await this._updateCartSql();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();

    return true;
  }

  /*删除购物车*/
  Future<bool> delCart() async {
    if (_selectionCartList == null || _selectionCartList.length == 0)
      return false;

    //根据条件删除CartList
    _selectionCartList.forEach((CartItem cartItem) {
      _cartList.removeWhere((CartItem e) =>
          (e.goodsId == cartItem.goodsId && e.skuId == cartItem.skuId));
    });
    //清空selectionCartList
    _selectionCartList.clear();

    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartSql();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  /*结算购物车*/
  Future<bool> settlementCarts(BuildContext context) async {
    if (double.parse(this.selectionCartListAllPrice) <= 0) {
      Fluttertoast.showToast(msg: "还没选中商品哦~~", gravity: ToastGravity.CENTER);
      return false;
    }

    MyLoading.eject();
    try {
      List<Map<String, dynamic>> postResult =
          await PostCheckCarts.post(cartItemList: _selectionCartList);
      bool checkCarts = true;
      //循环检查是否有失效商品
      postResult.forEach((Map<String, dynamic> mapItem) {
        if (mapItem["isValid"] == 0) {
          checkCarts = false;
          int whereIndex = _cartList.indexWhere((CartItem e) =>
              (e.goodsId == mapItem["goodsId"] && e.skuId == mapItem["skuId"]));
          _cartList[whereIndex].isValid = 0;
          _cartList[whereIndex].isChoice = 0;
        }
      });
      MyLoading.shut();
      if (!checkCarts) {
        //更新选中列表
        this._updateSelectionCartList();
        //更新数据库
        await this._updateCartSql();
        //提示
        Fluttertoast.showToast(msg: "检测到您的勾选商品中包含失效商品~~");
        //更新
        notifyListeners();
      } else {
        //跳转订单提交页面
        return true;
      }
    } catch (e) {
      print(e.toString());
      MyLoading.shut();
    }
  }
}
