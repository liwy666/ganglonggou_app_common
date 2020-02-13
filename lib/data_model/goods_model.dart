import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/user_info_model.dart';
import 'package:ganglong_shop_app/models/attributeValueItem.dart';
import 'package:ganglong_shop_app/models/extraGoodsInfo.dart';
import 'package:ganglong_shop_app/models/goodsAttribute.dart';
import 'package:ganglong_shop_app/models/goodsInfo.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';
import 'package:ganglong_shop_app/models/goodsSkuItem.dart';
import 'package:ganglong_shop_app/models/goodsSkuOptionsItem.dart';
import 'package:ganglong_shop_app/page/components/my_loading.dart';
import 'package:ganglong_shop_app/request/fetch_extra_goods_info.dart';
import 'package:ganglong_shop_app/request/post_user_get_coupon.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:ganglong_shop_app/service/wechat_service.dart';
import 'package:flutter_des/flutter_des.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as Image2;

class GoodsModel extends ChangeNotifier {
  final List<GoodsItem> goodsList;
  final int goodsId;
  final UserInfoModel userInfoModel;
  final BuildContext pageContext;
  GoodsItem _goodsItem;
  GoodsInfo _goodsInfo;
  ExtraGoodsInfo _extraGoodsInfo;
  List<String> _goodsDetails;
  double _pageTop = 0;
  List<GoodsSkuOptionsItem> _goodsSkuOptions = [];
  bool _loadFinish = false;
  WeChatService _weChatService;

  GoodsInfo get goodsInfo => _goodsInfo;

  GoodsItem get goodsItem => _goodsItem;

  ExtraGoodsInfo get extraGoodsInfo => _extraGoodsInfo;

  double get pageTop => _pageTop;

  List<String> get goodsDetails => _goodsDetails;

  bool get loadFinish => _loadFinish;

  List<GoodsSkuOptionsItem> get goodsSkuOptions => _goodsSkuOptions;

  GoodsModel({@required this.goodsList, @required this.goodsId,@required this.userInfoModel,@required this.pageContext }) {
    this._goodsItem = this.goodsList.firstWhere(
        (element) => (element.goods_id == this.goodsId),
        orElse: () => null);
    if (_goodsItem != null) {
      //格式化商品信息
      this._initGoodsInfo();
      //初始化商品列表
      this._initGoodsDetails();
      //初始化商品sku选项
      this._initGoodsSkuOptions();
      //获取额外信息
      FetchExtraGoodsInfo.fetch(goodsId: this.goodsId).then((result) {
        this._extraGoodsInfo = result;
        this._updateGoodsInfo();
        this._loadFinish = true;
        notifyListeners();
      });
    } else {
      Fluttertoast.showToast(msg: "没有查找到该商品，可能已被下架");
    }
  }

  /*格式化商品信息*/
  _initGoodsInfo() {
    this._goodsInfo = GoodsInfo.fromJson({});
    this._goodsInfo.goodsPrice = double.parse(this._goodsItem.shop_price);
    this._goodsInfo.marketPrice = double.parse(this._goodsItem.market_price);
    this._goodsInfo.goodsImg = this._goodsItem.goods_img;
    this._goodsInfo.goodsSn = this._goodsItem.goods_sn;
    this._goodsInfo.goodsId = this._goodsItem.goods_id;
    this._goodsInfo.goodsStock = this._goodsItem.goods_stock;
    this._goodsInfo.catId = this._goodsItem.cat_id;
    this._goodsInfo.goodsName = this._goodsItem.goods_name;
    this._goodsInfo.goodsHeadName = this._goodsItem.goods_head_name;
    this._goodsInfo.goodsSalesVolume = this._goodsItem.goods_sales_volume;
    this._goodsInfo.isPromote = this._goodsItem.is_promote;
    this._goodsInfo.promoteNumber = this._goodsItem.promote_number;
    this._goodsInfo.promoteStartDate = this._goodsItem.promote_start_date;
    this._goodsInfo.promoteEndDate = this._goodsItem.promote_end_date;

    this._goodsInfo.goodsNumber = 1;
  }

  /*初始化商品详情*/
  _initGoodsDetails() {
    List<String> goodsDetails = [];
    RegExp reg = new RegExp(r"<img.*?(?:>|\/>)");
    Iterable<Match> matches = reg.allMatches(this._goodsItem.goods_desc);
    for (Match m in matches) {
      RegExp srcReg = new RegExp("src=['\"]?([^'\"]*)['\"]?");
      Iterable<Match> matches2 = srcReg.allMatches(m.group(0));
      for (Match m2 in matches2) {
        goodsDetails.add(m2.group(1));
      }
    }
    this._goodsDetails = goodsDetails;

    const string =
        "Java, android, ios, get the same result by DES encryption and decryption.";
    const key = "u1BvOHzUOcklgNpn1MaWvdn9DT4LyzSX";
    const iv = "12345678";
    FlutterDes.encryptToBase64(string, key, iv: iv).then((val) {
      print("FlutterDes:$val");
    });
  }

  /*初始化商品sku*/
  _initGoodsSkuOptions() {
    this._goodsItem.attribute.forEach((GoodsAttribute item) {
      String attributeName = item.attribute_name;
      List<Map<String, dynamic>> attributeValue = [];
      for (int i = 0; i < item.attribute_value.length; i++) {
        attributeValue.add({
          'name': item.attribute_value[i],
          "choiceFlag": i == 0 ? true : false
        });
      }
      this._goodsSkuOptions.add(GoodsSkuOptionsItem.fromJson(
          {"attributeName": attributeName, "attributeValue": attributeValue}));
    });
  }

  /*更新商品信息*/
  _updateGoodsInfo() {
    //拼接选中sku_desc
    List<String> skuDescArray = [];
    this._goodsSkuOptions.forEach((GoodsSkuOptionsItem item) {
      item.attributeValue.forEach((AttributeValueItem item2) {
        if (item2.choiceFlag) {
          skuDescArray.add(item2.name);
        }
      });
    });
    String skuDesc = skuDescArray.join(',');
    this._extraGoodsInfo.goods_sku.forEach((GoodsSkuItem item) {
      if (item.sku_desc == skuDesc) {
        this._goodsInfo.oneGoodsPrice = double.parse(item.sku_shop_price);
        this._goodsInfo.marketPrice = double.parse(item.sku_market_price);
        this._goodsInfo.goodsStock = item.sku_stock;
        this._goodsInfo.goodsAttributeImg = item.img_url;
        this._goodsInfo.skuId = item.sku_id;
        this._goodsInfo.attrDesc = item.sku_desc;
        this._goodsInfo.oneIntegral = item.integral;
        this._goodsInfo.oneGiveIntegral = item.give_integral;
      }
    });
    //商品价格
    this._goodsInfo.goodsPrice =
        this._goodsInfo.oneGoodsPrice * this._goodsInfo.goodsNumber;
    //获取积分
    this._goodsInfo.giveIntegral =
        this._goodsInfo.oneGiveIntegral * this._goodsInfo.goodsNumber;
    //使用积分
    this._goodsInfo.integral =
        this._goodsInfo.oneIntegral * this._goodsInfo.goodsNumber;
    //积分描述
    this._goodsInfo.integralDesc =
        "购买可得${this._goodsInfo.giveIntegral}$INTEGRAL_NAME";
  }

  /*更新滑动距离*/
  setPageTop({@required double pageTop}) {
    this._pageTop = pageTop;
    notifyListeners();
  }

  /*切换商品SKU*/
  switchGoodsSku(
      {@required int skuOptionsAlignIndex, @required int skuOptionItemIndex}) {
    if (this.goodsSkuOptions.length > 0) {
      //遍历对应SKU分组,赋值为false
      for (int i = 0;
          i < this.goodsSkuOptions[skuOptionsAlignIndex].attributeValue.length;
          i++) {
        this
            .goodsSkuOptions[skuOptionsAlignIndex]
            .attributeValue[i]
            .choiceFlag = false;
      }

      //赋值对应skuOptionItem为true
      this
          .goodsSkuOptions[skuOptionsAlignIndex]
          .attributeValue[skuOptionItemIndex]
          .choiceFlag = true;

      //更新商品信息
      this._updateGoodsInfo();
      notifyListeners();
    }
  }

  /*切换商品数量*/
  updGoodsInfoNumber(int goodsNumber) {
    this.goodsInfo.goodsNumber = goodsNumber;
    this._updateGoodsInfo();
    notifyListeners();
  }

  /*分享微信*/
  Future shareWeChatFriend(scene) async {
    MyLoading.eject();
    final Uri resolved = Uri.base.resolve(_goodsInfo.goodsAttributeImg);
    final HttpClientRequest request = await HttpClient().getUrl(resolved);
    final HttpClientResponse response = await request.close();
    final Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    Image2.Image image = Image2.decodeImage(bytes);
    Image2.Image thumbnail = Image2.copyResize(image, width: 100);
    _weChatService = WeChatService()
      ..weChat.shareWebpage(
          scene: scene,
          webpageUrl: WECHAT_FRIEND_SHARE_URL + goodsId.toString(),
          description: "江苏岗隆数码科技有限公司-您身边的数码产品服务商",
          title: _goodsInfo.goodsName,
          thumbData: Image2.encodeJpg(thumbnail));
    MyLoading.shut();
  }

  ///领取优惠券
  Future<void> userGetCoupon(int couponId) async{
    if(!userInfoModel.isLogon){
      Application.router.navigateTo(pageContext, "/logon?showBar=true");
      return;
    }
    String result = await PostUserGetCoupon.post(userToken:userInfoModel.userInfo.user_token, couponId: couponId);
    Fluttertoast.showToast(msg: result);

  }

  @override
  void dispose() {
    if (_weChatService != null) {
      _weChatService.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }
}
