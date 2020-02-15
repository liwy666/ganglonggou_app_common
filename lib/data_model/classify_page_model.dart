import 'dart:convert';

import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/classifyItem.dart';
import 'package:ganglong_shop_app/routes/application.dart';

class ClassifyPageModel with ChangeNotifier {
  int _choiceClassifyItemId = 0;
  List<ClassifyItem> classifyItemList = [];

  int get choiceClassifyItemId => _choiceClassifyItemId;

  List<ClassifyItem> get classifyItemChildren {
    if (_choiceClassifyItemId == 0) {
      return [];
    }
    List<ClassifyItem> classifyItemChildren = classifyItemList
        .firstWhere((ClassifyItem classifyItem) =>
            (classifyItem.id == _choiceClassifyItemId))
        .children;

    return classifyItemChildren;
  }

  set choiceClassifyItemId(int val) {
    if (val != _choiceClassifyItemId) {
      _choiceClassifyItemId = val;
      notifyListeners();
    }
  }

  ClassifyPageModel({@required List<ClassifyItem> classifyItemListTemp}) {
    if (classifyItemListTemp.length > 0) {
      this.classifyItemList = classifyItemListTemp
          .where(
              (ClassifyItem classifyItem) => classifyItem.children.length > 0)
          .toList();
      print(this.classifyItemList.length);
      _choiceClassifyItemId = this.classifyItemList[0].id;
    }
  }

  void classifyChildClick(
      {@required BuildContext context, @required ClassifyItem classifyItem}) {
    if (classifyItem != null &&
        classifyItem.classify_name.isNotEmpty &&
        classifyItem.classify_name != null) {
      Application.router.navigateTo(context,
          'search_goods_complete?keyword=${base64UrlEncode(utf8.encode(classifyItem.classify_name))}&showKeyword=false');
    }
  }
}
