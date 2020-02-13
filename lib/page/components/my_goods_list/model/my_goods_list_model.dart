import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';

class MyGoodsListModel with ChangeNotifier {
  final ScrollController scrollController;
  final List<GoodsItem> initialGoodsList;
  int _initialGoodsListLength;
  List<GoodsItem> _goodsList = [];
  //List<GoodsItem> _tempGoodsList = [];
  int _page = 1;
  int _limit = 8; //每次加载数据条数
  bool _isLoading = false; //是否正在请求新数据
  bool _isFinish = false; //数据是否加载完成

  List<GoodsItem> get goodsList => _goodsList;

  bool get isLoading => _isLoading;

  bool get isFinish => _isFinish;

  set setGoodsList(List<GoodsItem> goodsList) {
    _goodsList = goodsList;
  }

  MyGoodsListModel({
    @required this.scrollController,
    @required this.initialGoodsList,
  }) {

    _initialGoodsListLength = initialGoodsList.length;

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        //_scrollBottomFunction();
      }
    });
    if (_initialGoodsListLength <= _limit) {
      _isFinish = true;
      _goodsList = initialGoodsList;
      notifyListeners();
    }else{
      _goodsList = initialGoodsList.sublist(0, _limit);
      initialGoodsList.removeRange(0,_limit);
      notifyListeners();
    }
    print(goodsList[0].goods_name);
  }


}
