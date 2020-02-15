import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/goods_list_data_model.dart';
import 'package:ganglong_shop_app/data_model/page_position_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_goods_list/my_goods_list_card.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'components/goods_item_compoent.dart';

// ignore: must_be_immutable
class SonClassifyPage extends StatefulWidget {
  final ClassifyItem parentClassifyItem;
  bool initGoodsListFlag = true;

  SonClassifyPage({Key key, @required this.parentClassifyItem})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SonClassifyPage();
  }
}

class _SonClassifyPage extends State<SonClassifyPage> {
  List<GoodsItem> _goodsList;
  GoodsListDataModel goodsListDataModel;
  bool ifInitGoodsList = true;

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    final _firstPageModel = Provider.of<FirstPageModel>(context);
    goodsListDataModel = Provider.of<GoodsListDataModel>(context);
    if (ifInitGoodsList) {
      this._goodsList = goodsListDataModel.getGoodsListByKeyWord(
          keyWord: widget.parentClassifyItem.classify_name);
      ifInitGoodsList = false;
    }

    // TODO: implement build
    return ProviderWidget<PagePositionModel>(
      model: PagePositionModel(
          factListenPagePositionFunction: (double pagePosition) {
        _firstPageModel.pagePosition = pagePosition;
      }),
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: 337 / 493),
        delegate: SliverChildBuilderDelegate((context, index) {
          return MyGoodsListCard(
            key: ValueKey(_goodsList[index].goods_id),
            item: _goodsList[index],
            index: index,
          );
        }, childCount: _goodsList.length),
      ),
      builder: (BuildContext context, PagePositionModel pagePositionModel,
          Widget _child) {
        return Scaffold(
          backgroundColor: _themeModel.pageBackgroundColor1,
          body: CustomScrollView(
            controller: pagePositionModel.controller,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  widget.parentClassifyItem.children.length > 0
                      ? Center(
                          child: Card(
                            margin: EdgeInsets.only(
                                top: 10,
                                bottom: widget.parentClassifyItem.bar_img !=
                                            null &&
                                        widget.parentClassifyItem.bar_img != ''
                                    ? 0
                                    : 10),
                            color: _themeModel.pageBackgroundColor2,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Wrap(
                                alignment: WrapAlignment.spaceBetween,
                                spacing: 0, // 主轴(水平)方向间距
                                runSpacing: 0, // 纵轴（垂直）方向间距
                                children: getClassifyPreviewList(),
                              ),
                            ),
                          ),
                        )
                      : Container(), //分类明细
                  widget.parentClassifyItem.bar_img != null &&
                          widget.parentClassifyItem.bar_img != ''
                      ? GestureDetector(
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom: 10,
                                top: widget.parentClassifyItem.children.length >
                                        0
                                    ? 0
                                    : 10),
                            child: Center(
                                child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: MyExtendedImage.network(
                                widget.parentClassifyItem.bar_img,
                                width: MediaQuery.of(context).size.width * 0.95,
                              ),
                            )),
                          ),
                          onTap: () {
                            FirstPageModel.classBannerToControl(
                                classifyItem: widget.parentClassifyItem,
                                context: context);
                          },
                        )
                      : Container(), //banner图
                ]),
              ),
              //商品列表
              _child,
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: pagePositionModel.floatingActionButtonChild,
            foregroundColor: Colors.white,
            heroTag:
                "son_classify_page_${widget.parentClassifyItem.classify_name}",
            onPressed: () {
              pagePositionModel.toTop();
            },
          ),
        );
      },
    );
  }

  List<Widget> getClassifyPreviewList() {
    List<Widget> classifyPreviewList =
        widget.parentClassifyItem.children.map((ClassifyItem classifyItem) {
      return _ClassifyPreview(
        key: ValueKey(classifyItem.classify_name),
        classifyPreviewName: classifyItem.classify_name,
        classifyPreviewImg: MyExtendedImage.network(classifyItem.logo_img,
            fit: BoxFit.fitWidth),
        updateGoodsList: () {
          this._goodsList = goodsListDataModel.getGoodsListByKeyWord(
              keyWord: classifyItem.classify_name);
          setState(() {});
        },
      );
    }).toList();
    classifyPreviewList.add(_ClassifyPreview(
      key: ValueKey("全部"),
      classifyPreviewName: "全部",
      classifyPreviewImg: MyExtendedImage.asset(
          "static_images/all_class_preview_logo.png",
          fit: BoxFit.fitWidth),
      updateGoodsList: () {
        this._goodsList = goodsListDataModel.getGoodsListByKeyWord(
            keyWord: widget.parentClassifyItem.classify_name);
        setState(() {});
      },
    ));

    return classifyPreviewList;
  }
}

class _ClassifyPreview extends StatelessWidget {
  final Widget classifyPreviewImg;
  final String classifyPreviewName;
  final Function updateGoodsList;

  _ClassifyPreview(
      {Key key,
      @required this.updateGoodsList,
      @required this.classifyPreviewImg,
      @required this.classifyPreviewName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return FlatButton(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width * 0.95 * 0.15,
            width: MediaQuery.of(context).size.width * 0.95 * 0.15,
            child: classifyPreviewImg,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              classifyPreviewName,
              style: TextStyle(
                  fontSize: SMALL_FONT_SIZE, color: _themeModel.fontColor2),
            ),
          )
        ],
      ),
      onPressed: () {
        updateGoodsList();
      },
    );
  }
}
