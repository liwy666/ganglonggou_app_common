import 'package:extended_image/extended_image.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/goods_list_data_model.dart';
import 'package:flutter_app/data_model/page_position_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'components/goods_item_compoent.dart';

// ignore: must_be_immutable
class SonClassifyPage extends StatefulWidget {
  final ClassifyItem parentClassifyItem;
  final double itemHeight = 60;
  final double itemWidth = 80;
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
    goodsListDataModel = Provider.of<GoodsListDataModel>(context);
    if (ifInitGoodsList) {
      this._goodsList = goodsListDataModel.getGoodsListByKeyWord(
          keyWord: widget.parentClassifyItem.classify_name);
      ifInitGoodsList = false;
    }

    // TODO: implement build
    return ProviderWidget<PagePositionModel>(
      model: PagePositionModel(),
      child: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 337 / 493),
        delegate: SliverChildBuilderDelegate((context, index) {
          return GoodsItemComponent(
              key: ValueKey(_goodsList[index].goods_id),
              item: _goodsList[index]);
        }, childCount: _goodsList.length),
      ),
      builder: (BuildContext context, PagePositionModel pagePositionModel,
          Widget _child) {
        return Scaffold(
          backgroundColor: _themeModel.pageBackgroundColor1,
          body: CustomScrollView(
            controller: pagePositionModel.controller,
            slivers: <Widget>[
              //banner图
              SliverList(
                delegate: SliverChildListDelegate([
                  Card(
                    color: _themeModel.pageBackgroundColor2,
                    child: Wrap(
                      //alignment: WrapAlignment.start,
                      spacing: 10, // 主轴(水平)方向间距
                      runSpacing: 4.0, // 纵轴（垂直）方向间距
                      children: getClassifyPreviewList(),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(25)),
                    child: Center(
                        child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: MyExtendedImage.network(
                        widget.parentClassifyItem.bar_img,
                        width: ScreenUtil().setWidth(700),
                      ),
                    )),
                  ),
                ]),
              ),
              //商品列表
              _child,
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: pagePositionModel.floatingActionButtonChild,
            foregroundColor: Colors.white,
            heroTag: "son_classify_page_${widget.parentClassifyItem.classify_name}",
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
        itemHeight: widget.itemHeight,
        itemWidth: widget.itemWidth,
        classifyPreviewName: classifyItem.classify_name,
        classifyPreviewImg: MyExtendedImage.network(classifyItem.logo_img),
        updateGoodsList: () {
          this._goodsList = goodsListDataModel.getGoodsListByKeyWord(
              keyWord: classifyItem.classify_name);
          setState(() {});
        },
      );
    }).toList();
    classifyPreviewList.add(_ClassifyPreview(
      key: ValueKey("全部"),
      itemHeight: widget.itemHeight,
      itemWidth: widget.itemWidth,
      classifyPreviewName: "全部",
      classifyPreviewImg:
          ExtendedImage.asset("static_images/all_class_preview_logo.png"),
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
  final double itemHeight;
  final double itemWidth;
  final Function updateGoodsList;

  _ClassifyPreview(
      {Key key,
      @required this.itemWidth,
      @required this.updateGoodsList,
      @required this.itemHeight,
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
            height: ScreenUtil().setWidth(itemWidth),
            width: ScreenUtil().setWidth(itemWidth),
            child: classifyPreviewImg,
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Text(
              classifyPreviewName,
              style:
                  TextStyle(fontSize: SMALL_FONT_SIZE, color: _themeModel.fontColor2),
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
