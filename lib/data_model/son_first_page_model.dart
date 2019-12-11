import 'package:flutter_app/common_import.dart';

class SonFirstPageModel with ChangeNotifier {
  double _newGoodsSwiperHeight = 800; //新品尝鲜的高度
  bool _newGoodsSwiperUpdateHeightFlag = true; //只刷新一次
  double _otherShopSwiperHeight = 800; //新品尝鲜的高度
  bool _otherShopSwiperUpdateHeightFlag = true; //只刷新一次
  double get newGoodsSwiperHeight => _newGoodsSwiperHeight;

  bool get newGoodsSwiperUpdateHeightFlag => _newGoodsSwiperUpdateHeightFlag;

  double get otherShopSwiperHeight => _otherShopSwiperHeight;

  bool get otherShopSwiperUpdateHeightFlag => _otherShopSwiperUpdateHeightFlag;

  //更新新品尝鲜版块高度
  updateNewGoodsSwiperHeight(double height) {
    if (_newGoodsSwiperUpdateHeightFlag) {
      this._newGoodsSwiperHeight = height;
      _newGoodsSwiperUpdateHeightFlag = false;
      notifyListeners();
    }
  }

  //更新平台店铺高度
  updateOtherShopSwiperHeight(double height) {
    if (_otherShopSwiperUpdateHeightFlag) {
      this._otherShopSwiperHeight = height;
      _otherShopSwiperUpdateHeightFlag = false;
      notifyListeners();
    }
  }
}
