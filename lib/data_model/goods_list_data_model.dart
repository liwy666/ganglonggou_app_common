import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';

class GoodsListDataModel with ChangeNotifier {
  List<GoodsItem> _goodsList;
  List<GoodsItem> _fistPageRecommendGoodsList; //首页推荐商品
  List<GoodsItem> _afterSearchGoodsList; //首页推荐商品

  List<GoodsItem> get goodsList => _goodsList;

  List<GoodsItem> get fistPageRecommendGoodsList => _fistPageRecommendGoodsList;

  List<GoodsItem> get afterSearchGoodsList => _afterSearchGoodsList;

  //初始化
  void init({@required List<GoodsItem> goodsList}) {
    _goodsList = goodsList;
    print("初始商品数量：${goodsList.length}");
    this._initFistPageRecommendGoodsList(); //初始化首页推荐商品
    this._initAfterSearchGoodsList(); //初始化搜索结果商品
  }

  //刷新
  void reFresh({@required List<GoodsItem> goodsList}) {
    this.init(goodsList: goodsList);
    notifyListeners();
  }

  //初始化首页推荐商品
  void _initFistPageRecommendGoodsList() {
    _fistPageRecommendGoodsList = _goodsList;
  }

  //初始化搜索结果商品
  void _initAfterSearchGoodsList() {
    _afterSearchGoodsList = _goodsList;
  }

  //通过关键词搜索商品
  List<GoodsItem> getGoodsListByKeyWord({@required String keyWord}) {
    keyWord = keyWord.toUpperCase().replaceAll(RegExp(r"(\s*)"), "");
    var goodsIdSet = new Set();
    List<GoodsItem> __afterSearchGoodsList = [];
    this._goodsList.forEach((GoodsItem goodsItem) {
      /*商品名称*/
      String goodsName =
          goodsItem.goods_name.toUpperCase().replaceAll(RegExp(r"(\s*)"), "");
      if (goodsName.contains(keyWord)) {
        goodsIdSet.add(goodsItem.goods_id);
      }
      /*分类名称*/
      String catName =
          goodsItem.cat_name.toUpperCase().replaceAll(RegExp(r"(\s*)"), "");
      if (catName.contains(keyWord)) {
        goodsIdSet.add(goodsItem.goods_id);
      }
      /*关键词*/
      String goodsKeyWord =
          goodsItem.keywords.toUpperCase().replaceAll(RegExp(r"(\s*)"), "");
      if (goodsKeyWord.contains(keyWord)) {
        goodsIdSet.add(goodsItem.goods_id);
      }
    });
    goodsIdSet.forEach((goodsId) {
      __afterSearchGoodsList.add(
          _goodsList.firstWhere((element) => (element.goods_id == goodsId)));
    });
    return __afterSearchGoodsList;
    /* notifyListeners();*/
  }
}
