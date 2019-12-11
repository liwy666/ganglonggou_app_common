import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/models/classifyItem.dart';
import 'package:flutter_app/models/classifyList.dart';
import 'package:flutter_app/page/first_page/son_page/son_classify_page.dart';
import 'package:flutter_app/page/first_page/son_page/son_first_page.dart';
import 'package:flutter_app/request/fetch_classify_list.dart';

class ClassifyListDataModel with ChangeNotifier {
  List<ClassifyItem> _classifyList;

  List<ClassifyItem> get classifyList => _classifyList;

  int get classifyListLength => _classifyList.length + 1;

  List<String> get headComponentTabs => _getHeadComponentTabs();

  List<Widget> get firstPageClassifyPage => _updateClassifyPage();

  //初始化
  void init(ClassifyList result) {
    _classifyList = _getTrees(result, 0);
  }

  /*刷新*/
  void reFresh(ClassifyList result) {
    this.init(result);
    notifyListeners();
  }

  /*更新分类页*/
  List<Widget> _updateClassifyPage() {
    List<Widget> tabBarView = [SonFirstPage(key: PageStorageKey<String>('首页'))];
    classifyList.forEach((v) {
      tabBarView.add(SonClassifyPage(
        key: PageStorageKey<String>(v.classify_name.toString()),
        parentClassifyItem: v,
      ));
    });
    return tabBarView;
  }

  /*获取头部Tab*/
  List<String> _getHeadComponentTabs() {
    List<String> _headComponentTabs = ['首页'];
    this._classifyList.forEach((v) {
      _headComponentTabs.add(v.classify_name);
    });
    return _headComponentTabs;
  }

  /*树状算法*/
  List<ClassifyItem> _getTrees(ClassifyList list, int parentId) {
    Map items = {};
    for (int i = 0; i < list.data.length; i++) {
      int key = list.data[i].parent_id;
      if (items[key] != null) {
        items[key].add(list.data[i]);
      } else {
        items[key] = [];
        items[key].add(list.data[i]);
      }
    }
    return this._formatTree(items, parentId);
  }

/*利用递归格式化每个节点*/
  List<ClassifyItem> _formatTree(Map items, int parentId) {
    List<ClassifyItem> result = [];
    if (items[parentId] == null) {
      return result;
    }
    items[parentId].forEach((v) {
      v.children = this._formatTree(items, v.id);
      result.add(v);
    });
    return result;
  }
}
