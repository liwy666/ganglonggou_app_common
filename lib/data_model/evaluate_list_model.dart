import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/goodsEvaluateItem.dart';
import 'package:flutter_app/page/evaluate_list_page/components/evaluate_item.dart';
import 'package:flutter_app/request/fetch_evaluate_list.dart';

class EvaluateListModel extends ChangeNotifier {
  List<GoodsEvaluateItem> _goodsEvaluateList = [];
  int goodsId;
  int _page = 1;
  int _limit = 4; //每次加载数据条数
  bool _isLoading = false; //是否正在请求新数据
  bool _isFinish = false; //数据是否加载完成

  List<GoodsEvaluateItem> get goodsEvaluateList => _goodsEvaluateList;

  bool get isLoading => _isLoading;

  bool get isFinish => _isFinish;

  EvaluateListModel({@required this.goodsId}) {
    this.fetchEvaluateList();
  }

  void fetchEvaluateList() {
    if (!this._isFinish && !this.isLoading) {
      this._isLoading = true;
      notifyListeners();
      FetchEvaluateList.fetch(
              goodsId: this.goodsId, limit: this._limit, page: this._page)
          .then((result) {
        //print(this._goodsEvaluateList.length);
        if (result.data.length < _limit) {
          this._isFinish = true;
        }
        result.data.forEach((GoodsEvaluateItem item) {
          this._goodsEvaluateList.add(item);
        });
        this._page++;
        this._isLoading = false;
        notifyListeners();
      });
    }
  }

  GoodsEvaluateItem getGoodsEvaluateItem(@required index) {
    if (_goodsEvaluateList.length > 0 && _goodsEvaluateList.length > index) {
      return _goodsEvaluateList[index];
    } else {
      return null;
    }
  }
}
