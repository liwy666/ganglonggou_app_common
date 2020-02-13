import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/models/classifyItem.dart';
import 'package:ganglong_shop_app/models/classifyList.dart';
import 'package:ganglong_shop_app/page/first_page/son_page/son_classify_page.dart';
import 'package:ganglong_shop_app/page/first_page/son_page/son_first_page.dart';
import 'package:ganglong_shop_app/request/fetch_classify_list.dart';

class ClassifyListDataModel with ChangeNotifier {
  List<ClassifyItem> _classifyList;

  List<ClassifyItem> get classifyList => _classifyList;

  int get classifyListLength => _classifyList.length + 1;

  List<String> get headComponentTabs => _getHeadComponentTabs();

  List<Widget> get firstPageClassifyPage => _updateClassifyPage();

  List<ClassifyItem> get navigationClassifyList => _getNavigationClassifyList();

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

  ///获取首页导航栏图标
  List<ClassifyItem> _getNavigationClassifyList() {
    List<ClassifyItem> _tempClassifyItemList = [];
    this._classifyList.forEach((ClassifyItem classifyItem) {
      _tempClassifyItemList.add(classifyItem);
    });
    //添加工行
    _tempClassifyItemList.add(ClassifyItem.fromJson({
      "click_type": "工行活动页",
      "classify_name": "工行免息",
      "logo_img": SON_FIRST_PAGE_ICBC_ICON,
    }));
    //添加优惠券
    _tempClassifyItemList.add(ClassifyItem.fromJson({
      "click_type": "领券活动页",
      "classify_name": "优惠券",
      "logo_img": SON_FIRST_PAGE_COUPONS_ICON,
    }));
    return _tempClassifyItemList;
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
