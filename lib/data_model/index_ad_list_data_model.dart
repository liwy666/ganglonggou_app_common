import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/index.dart';

class IndexAdListDataModel with ChangeNotifier {
  List<IndexAdItem> _indexList;
  List<IndexAdItem> _swiperList; //顶部轮播
  List<IndexAdItem> _lonelyBanner; //孤立通栏
  List<IndexAdItem> _newGoodsList; //新品尝鲜
  List<IndexAdItem> _brandTogetherList; //品牌惠聚
  List<IndexAdItem> _otherShopList; //品牌惠聚

  List<IndexAdItem> get indexList => _indexList;

  List<IndexAdItem> get swiperList => _swiperList;

  List<IndexAdItem> get lonelyBanner => _lonelyBanner;

  List<IndexAdItem> get newGoodsList => _newGoodsList;

  List<IndexAdItem> get brandTogetherList => _brandTogetherList;

  List<IndexAdItem> get otherShopList => _otherShopList;

  //初始化
  void init({@required List<IndexAdItem> indexList}) {
    _indexList = indexList;
    this._swiperList = [];
    this._newGoodsList = [];
    this._brandTogetherList = [];
    this._otherShopList = [];
    this._lonelyBanner = [];
    this._indexList.forEach((indexAdItem) {
      switch (indexAdItem.position_type) {
        case "顶部轮播":
          this._swiperList.add(indexAdItem);
          break;
        case "孤立通栏":
          this._lonelyBanner.add(indexAdItem);
          break;
        case "新品尝鲜-商品":
          this._newGoodsList.add(indexAdItem);
          break;
        case "品牌惠聚-内容":
          this._brandTogetherList.add(indexAdItem);
          break;
        case "平台店铺-内容":
          this._otherShopList.add(indexAdItem);
          break;
      }
    });
  }

  /*刷新*/
  void reFresh({@required List<IndexAdItem> indexList}) {
    this.init(indexList: indexList);
    super.notifyListeners();
  }
}
