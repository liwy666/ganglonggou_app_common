import 'package:ganglong_shop_app/common_import.dart';

class GoodsTitleModel with ChangeNotifier {
  //当前激活按钮位置
  int _activateIndex = 0;
  final ScrollController controller;
  final List<GoodsTitleButtonItemData> buttonTitles;
  final Map<String, double> widgetOffset;

  GoodsTitleModel({
    @required this.controller,
    @required this.buttonTitles,
    @required this.widgetOffset,
  });

  int get activateIndex => _activateIndex;

  set activateIndex(int val) {
    if (val == _activateIndex) return;
    _activateIndex = val;
    notifyListeners();
  }

  init() {
    controller.addListener(() {
      final List<double> widgetOffsetList = [];
      this.widgetOffset.forEach((String key, double value) {
        widgetOffsetList.add(value);
      });
      int index = _getListIndexByDouble(controller.offset, widgetOffsetList);
      if (index != _activateIndex) {
        _activateIndex = index;
        notifyListeners();
      }
    });
  }

  ///通过数值获取数组下标
  int _getListIndexByDouble(double value, List<double> list) {
    if (list.length == 0) return 0;
    int result = 0;
    for (int i = 0; i < list.length - 1; i++) {
      if (value >= list[list.length - 1]) {
        result = list.length - 1;
      } else if (value >= list[i] && value < list[i + 1]) {
        result = i;
      }
    }
    return result;
  }
}

///按钮构建对象
class GoodsTitleButtonItemData {
  final String goodsTitleButtonTitle;
  final String pagePositionKey;
  final int thisIndex;
  final Function callBackFunction;

  GoodsTitleButtonItemData({
    this.goodsTitleButtonTitle,
    this.pagePositionKey,
    this.thisIndex,
    this.callBackFunction,
  });
}
