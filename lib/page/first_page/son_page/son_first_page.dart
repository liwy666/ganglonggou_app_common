import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/classify_list_ad_model.dart';
import 'package:flutter_app/data_model/goods_list_data_model.dart';
import 'package:flutter_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_app/data_model/page_position_model.dart';
import 'package:flutter_app/data_model/son_first_page_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/classifyItem.dart';
import 'package:flutter_app/models/classifyList.dart';
import 'package:flutter_app/models/goodsItem.dart';
import 'package:flutter_app/models/indexAdItem.dart';
import 'package:flutter_app/models/indexInfo.dart';
import 'package:flutter_app/page/components/my_goods_list/my_goods_list.dart';
import 'package:flutter_app/page/first_page/son_page/components/brand_together_component.dart';
import 'package:flutter_app/page/first_page/son_page/components/first_title_component.dart';
import 'package:flutter_app/page/first_page/son_page/components/grid_navigation_component.dart';
import 'package:flutter_app/page/first_page/son_page/components/other_shop_component.dart';
import 'package:flutter_app/page/first_page/son_page/components/solitary_banner_component.dart';
import 'package:flutter_app/page/first_page/son_page/components/swiper_component.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/request/fetch_classify_list.dart';
import 'package:flutter_app/request/fetch_index_info.dart';
import 'package:flutter_app/sqflite_model/classify_sqflite.dart';
import 'package:flutter_app/sqflite_model/goods_sqflite.dart';
import 'package:flutter_app/sqflite_model/index_ad_sqflite.dart';
import 'package:provider/provider.dart';
import 'components/new_goods_swiper_component.dart';

class SonFirstPage extends StatefulWidget {
  SonFirstPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SonFirstPage();
  }
}

class _SonFirstPage extends State<SonFirstPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return ProviderWidget2<SonFirstPageModel, PagePositionModel>(
      model1: SonFirstPageModel(),
      model2: PagePositionModel(),
      builder: ((BuildContext context, SonFirstPageModel sonFirstPageModel,
          PagePositionModel pagePositionModel, _) {
        return Scaffold(
          backgroundColor: _themeModel.pageBackgroundColor1,
          body: RefreshIndicator(
            onRefresh: () async {
              await _onRefresh(context);
            },
            child: Consumer<GoodsListDataModel>(
              builder: (BuildContext context, GoodsListDataModel goodsList, _) {
                return MyGoodsList(
                  scrollController: pagePositionModel.controller,
                  initialGoodsList: goodsList.fistPageRecommendGoodsList,
                  headWidgetList: <Widget>[
                    SwiperComponent(),
                    GridNavigationComponent(),
                    SolitaryBannerComponent(),
                    NewGoodsSwiperComponent(),
                    BrandTogetherComponent(),
                    OtherShopComponent(),
                    FirstTitleComponent(
                        textColor: Colors.red, firstText: "推荐", lastText: "榜单"),
                  ],
                );
              },
            ),
          ),
          floatingActionButton: !pagePositionModel.showToTopBtn
              ? null
              : FloatingActionButton(
                  child: pagePositionModel.floatingActionButtonChild,
                  foregroundColor: Colors.white,
                  heroTag: "son_first_page",
                  onPressed: () {
                    pagePositionModel.toTop();
                  }),
        );
      }),
    );
  }
}

Future<void> _onRefresh(BuildContext context) async {
  //获取远程数据
  IndexInfo indexInfoModel = await FetchIndexInfo.fetch();
  ClassifyList classifyList = await FetchClassifyList.fetch();
  //获取model
  final goodsListDataModel = Provider.of<GoodsListDataModel>(context);
  final indexAdListDataModel = Provider.of<IndexAdListDataModel>(context);
  final classifyListDataModel = Provider.of<ClassifyListDataModel>(context);
  //更新model
  goodsListDataModel.reFresh(goodsList: indexInfoModel.goods_list);
  indexAdListDataModel.reFresh(indexList: indexInfoModel.ad_list);
  classifyListDataModel.reFresh(classifyList);
  //更新数据库
  await GoodsSqflite().insertAllDate<GoodsItem>(indexInfoModel.goods_list);
  await IndexAdSqflite().insertAllDate<IndexAdItem>(indexInfoModel.ad_list);
  await ClassifySqflite().insertAllDate<Map<String, dynamic>>(
      classifyList.data.map((ClassifyItem item) {
    Map<String, dynamic> mapItem = item.toJson();
    mapItem.remove('children');
    return mapItem;
  }).toList());
}
