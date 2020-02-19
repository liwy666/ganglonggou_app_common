import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/cartItem.dart';
import 'package:ganglong_shop_app/models/goodsInfo.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/page/components/my_toast.dart';
import 'package:ganglong_shop_app/request/post_check_carts.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:ganglong_shop_app/sqflite_model/cart_sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartDataModel extends ChangeNotifier {
  List<CartItem> _cartList;
  UserInfoModel _userInfoModel;

  List<CartItem> get cartList => _cartList;

  List<CartItem> get selectionCartList {
    if (cartList == null || cartList.length < 1) return [];

    return _cartList.where((CartItem e) => (e.isChoice == 1)).toList();
  }

  bool get allChoice => cartList.length == selectionCartList.length;

  ///总价格
  String get selectionCartListAllPrice => _getSelectionCartListAllPrice();

  ///总积分
  int get selectionCartListAllIntegral => _getSelectionCartListAllIntegral();

  ///初始化
  Future<void> init({@required UserInfoModel userInfoModel}) async {
    if (userInfoModel == null) return;
    _userInfoModel = userInfoModel;
    //获取购物车数据
    List<Map<String, dynamic>> cartSqlQueryAll = [];
    if (_userInfoModel.isLogon) {
      cartSqlQueryAll = await CartSqFlite()
          .queryUserAllCart(userId: _userInfoModel.userInfo.user_id);
    }
    //初始化购物车
    _cartList = cartSqlQueryAll.map((Map<String, dynamic> mapItem) {
      return CartItem.fromJson(mapItem);
    }).toList();
  }

  ///更新_cartList数据
  Future<void> _updateCartList() async {
    List<Map<String, dynamic>> cartSqlQueryAll = await CartSqFlite()
        .queryUserAllCart(userId: _userInfoModel.userInfo.user_id);
    _cartList = cartSqlQueryAll.map((Map<String, dynamic> mapItem) {
      return CartItem.fromJson(mapItem);
    }).toList();
  }

  ///获取选中列表的价格总和
  String _getSelectionCartListAllPrice() {
    if (selectionCartList.length == 0 || selectionCartList == null)
      return 0.toRadixString(2);
    double price = 0;
    selectionCartList.forEach((CartItem item) {
      price += item.goodsPrice;
    });

    return price.toStringAsFixed(2);
  }

  ///获取可使用积分总和
  int _getSelectionCartListAllIntegral() {
    if (selectionCartList.length == 0 || selectionCartList == null) return 0;
    int integral = 0;
    selectionCartList.forEach((CartItem item) {
      integral += item.oneIntegral * item.goodsNumber;
    });
    return integral;
  }

  ///添加购物车
  Future<bool> addCart({@required GoodsInfo goodsInfo}) async {
    if (!_userInfoModel.isLogon) return false;
    CartItem waitAddCartItem = CartItem.fromJson(goodsInfo.toJson());
    //设置默认为选中和有效
    waitAddCartItem.isChoice = 1;
    waitAddCartItem.isValid = 1;
    waitAddCartItem.userId = _userInfoModel.userInfo.user_id;
    //判断购物车是否有这件商品
    CartItem whereCartItem = _cartList.firstWhere(
        (CartItem e) =>
            (e.goodsId == goodsInfo.goodsId && e.skuId == goodsInfo.skuId),
        orElse: () => (null));
    if (whereCartItem == null) {
      /*如果没有这件商品就添加*/
      await CartSqFlite().insertData(waitAddCartItem.toJson());
    } else {
      /*如果有就更新数量*/
      await updCartNumber(
          cartNumber: whereCartItem.goodsNumber + 1,
          cartId: whereCartItem.cartId);
    }

    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartList();
    //关闭加载
    MyLoading.shut();
    //通知用户添加成功
    MyToast.showToast(msg: "已帮您将商品加入购物车");
    //通知更新
    notifyListeners();
    return true;
  }

  ///修改购物车数量
  Future<bool> updCartNumber(
      {@required int cartNumber, @required int cartId}) async {
    CartItem whereCartItem = _cartList
        .firstWhere((CartItem e) => (e.cartId == cartId), orElse: () => (null));
    if (whereCartItem == null) return false;
    //检查库存
    if (cartNumber > whereCartItem.goodsStock) {
      MyToast.showToast(msg: "哎呀，库存不足了");
      return false;
    }
    //更新数量和购物车价格
    double goodsPrice =
        double.parse((cartNumber * whereCartItem.oneGoodsPrice).toString());
    await CartSqFlite().updateCartNumber(
        cartId: cartId, cartNumber: cartNumber, cartPrice: goodsPrice);

    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartList();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  ///切换选中状态
  Future<bool> switchCartChoiceState({@required int cartId}) async {
    CartItem whereCartItem = _cartList
        .firstWhere((CartItem e) => (e.cartId == cartId), orElse: () => (null));
    if (whereCartItem == null) return false;
    await CartSqFlite().switchCartChoiceState(
        cartId: cartId, isChoice: whereCartItem.isChoice == 1 ? 0 : 1);
    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartList();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  ///全选事件
  Future<bool> switchAllChoice() async {
    if (selectionCartList == null) return false;
    if (selectionCartList.length < _cartList.length) {
      //全选
      for (int i = 0; i < _cartList.length; i++) {
        await CartSqFlite()
            .switchCartChoiceState(cartId: _cartList[i].cartId, isChoice: 1);
      }
    } else {
      //全不选
      for (int i = 0; i < _cartList.length; i++) {
        await CartSqFlite()
            .switchCartChoiceState(cartId: _cartList[i].cartId, isChoice: 0);
      }
    }
    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartList();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();

    return true;
  }

  ///删除购物车
  Future<bool> delCart() async {
    if (selectionCartList == null || selectionCartList.length == 0)
      return false;

    //根据条件删除CartList
    selectionCartList.forEach((CartItem cartItem) async {
      await CartSqFlite().delCart(cartId: cartItem.cartId);
    });
    //加载框
    MyLoading.eject();
    //更新数据库
    await this._updateCartList();
    //关闭加载
    MyLoading.shut();
    //通知更新
    notifyListeners();
    return true;
  }

  ///结算购物车
  Future<bool> settlementCarts(BuildContext context) async {
    if (double.parse(this.selectionCartListAllPrice) <= 0) {
      MyToast.showToast(msg: "还没选中商品哦~~", gravity: ToastGravity.CENTER);
      return false;
    }

    MyLoading.eject();
    try {
      List<Map<String, dynamic>> postResult =
          await PostCheckCarts.post(cartItemList: selectionCartList);
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
        //更新数据库
        await this._updateCartList();
        //提示
        MyToast.showToast(msg: "检测到您的勾选商品中包含失效商品~~");
        //更新
        notifyListeners();
        return false;
      } else {
        //跳转订单提交页面
        return true;
      }
    } catch (e) {
      print(e);
      MyLoading.shut();
      return false;
    }
  }

  ///立即购买
  Future<void> immediateBuy(
      {@required GoodsInfo goodsInfo, @required BuildContext context}) async {
    try {
      //关闭所有选中
      if (selectionCartList.length > 0 && !allChoice) {
        await switchAllChoice();
        await switchAllChoice();
      } else if (selectionCartList.length > 0 && allChoice) {
        await switchAllChoice();
      }
      //添加购物车
      await addCart(goodsInfo: goodsInfo);
      //跳转订单界面
      Application.router.navigateTo(context, '/write_order');
    } catch (e) {
      print(e);
    }
  }
}
