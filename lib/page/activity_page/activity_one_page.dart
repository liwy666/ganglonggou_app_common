import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/classify_list_ad_model.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/goods_list_data_model.dart';
import 'package:ganglong_shop_app/models/classifyItem.dart';
import 'package:ganglong_shop_app/models/goodsItem.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_goods_list/my_goods_list.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:provider/provider.dart';

class ActivityOnePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityOnePage();
  }
}

class _ActivityOnePage extends State<ActivityOnePage> {
  GoodsListDataModel _goodsListDataModel;
  ClassifyListDataModel _classifyListDataModel;
  List<GoodsItem> _goodsList;
  ClassifyItem _parentClassifyItem;
  ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _goodsListDataModel = Provider.of<GoodsListDataModel>(context);
    _classifyListDataModel = Provider.of<ClassifyListDataModel>(context);
    _goodsList = _goodsListDataModel.getGoodsListByKeyWord(keyWord: '现货专区');
    _parentClassifyItem = _classifyListDataModel.classifyList.firstWhere(
        (ClassifyItem classifyItem) => (classifyItem.classify_name == '现货专区'),
        orElse: null);
    // TODO: implement build
    return Scaffold(
      appBar: MyTabBar(
        tabBarName: '现货专区',
      ),
      body: _parentClassifyItem == null
          ? Container()
          : MyGoodsList(
              headWidgetList: <Widget>[
                _parentClassifyItem.bar_img != null &&
                        _parentClassifyItem.bar_img != ''
                    ? GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: 10,
                              top: _parentClassifyItem.children.length > 0
                                  ? 0
                                  : 10),
                          child: Center(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: MyExtendedImage.network(
                              _parentClassifyItem.bar_img,
                              width: MediaQuery.of(context).size.width * 0.95,
                            ),
                          )),
                        ),
                        onTap: () {
                          FirstPageModel.classBannerToControl(
                              classifyItem: _parentClassifyItem,
                              context: context);
                        },
                      )
                    : Container(),
              ],
              initialGoodsList: _goodsList,
              scrollController: _scrollController,
            ),
    );
  }
}
