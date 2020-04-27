import 'package:flutter/cupertino.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/data_model/goods_title_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/provider/provider_widget.dart';
import 'package:provider/provider.dart';

class GoodsTitle extends StatefulWidget {
  final ScrollController controller;
  final double _itemWithe = 45;
  final List<GoodsTitleButtonItemData> _buttonTitles = [
    GoodsTitleButtonItemData(
        goodsTitleButtonTitle: "商品", pagePositionKey: "goods", thisIndex: 0),
    GoodsTitleButtonItemData(
        goodsTitleButtonTitle: "评价", pagePositionKey: "evaluate", thisIndex: 1),
    GoodsTitleButtonItemData(
        goodsTitleButtonTitle: "推荐",
        pagePositionKey: "recommend",
        thisIndex: 2),
    GoodsTitleButtonItemData(
        goodsTitleButtonTitle: "详情",
        pagePositionKey: "described",
        thisIndex: 3),
  ];

  GoodsTitle({Key key, this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoodsTitle();
  }
}

class _GoodsTitle extends State<GoodsTitle> {
  double _opacityValue = 0;
  double _baseOffset = 500;

  @override
  void initState() {
    widget.controller.addListener(() {
      if (widget.controller.offset >= 0 && widget.controller.offset <= 500) {
        setState(() {
          if (widget.controller.offset <= 50) {
            _opacityValue = 0;
          } else {
            _opacityValue = widget.controller.offset / _baseOffset > 1
                ? 1
                : widget.controller.offset / _baseOffset;
          }
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsModel>(
      child: Opacity(
        opacity: _opacityValue,
        child: _opacityValue > 0
            ? Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: widget._buttonTitles
                        .map((GoodsTitleButtonItemData item) {
                      return _GoodsTitleButton(
                        goodsTitleButtonItemData: item,
                        itemWithe: widget._itemWithe,
                        controller: widget.controller,
                      );
                    }).toList(),
                  ),
                  _GoodsTitleTwig(
                    itemWithe: widget._itemWithe,
                  ),
                ],
              )
            : Container(),
      ),
      builder: (BuildContext context, GoodsModel goodsModel,
          Widget goodsModelChild) {
        return ProviderWidget<GoodsTitleModel>(
          model: GoodsTitleModel(
              controller: widget.controller,
              buttonTitles: widget._buttonTitles,
              widgetOffset: goodsModel.widgetOffset),
          onModelReady: (GoodsTitleModel goodsTitleModel) {
            goodsTitleModel.init();
          },
          child: goodsModelChild,
          builder: (BuildContext context, GoodsTitleModel goodsTitleModel,
              Widget goodsTitleModelChild) {
            return goodsTitleModelChild;
          },
        );
      },
    );
  }
}

class _GoodsTitleButton extends StatelessWidget {
  //按钮名称
  final GoodsTitleButtonItemData goodsTitleButtonItemData;

  final double itemWithe;
  final ScrollController controller;

  const _GoodsTitleButton(
      {Key key,
      @required this.goodsTitleButtonItemData,
      @required this.itemWithe,
      @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsTitleModel>(
      child: Container(
        width: itemWithe,
        padding: EdgeInsets.only(bottom: 5),
        child: Text(goodsTitleButtonItemData.goodsTitleButtonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SMALL_FONT_SIZE,
              color: Colors.black,
            )),
      ),
      builder: (BuildContext context, GoodsTitleModel goodsTitleModel, child) {
        return Consumer<GoodsModel>(
          builder: (BuildContext context, GoodsModel goodsModel, _) {
            return GestureDetector(
              child: child,
              onTap: () {
                //改变页面位置
                controller.animateTo(
                    goodsModel
                        .widgetOffset[goodsTitleButtonItemData.pagePositionKey],
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease);
                //启动动画
                goodsTitleModel.activateIndex =
                    goodsTitleButtonItemData.thisIndex;
              },
            );
          },
        );
      },
    );
  }
}

class _GoodsTitleTwig extends StatefulWidget {
  final double itemWithe;
  final double _twigHeight = 2;

  const _GoodsTitleTwig({Key key, this.itemWithe}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return __GoodsTitleTwig();
  }
}

class __GoodsTitleTwig extends State<_GoodsTitleTwig> {
  @override
  Widget build(BuildContext context) {
    final ThemeModel _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Consumer<GoodsTitleModel>(
      builder: (BuildContext context, GoodsTitleModel goodsTitleModel, _) {
        var duration = Duration(milliseconds: 150);
        return Container(
          width: widget.itemWithe * 4,
          height: widget._twigHeight,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                duration: duration,
                top: 0,
                left: widget.itemWithe * goodsTitleModel.activateIndex,
                child: Container(
                  width: widget.itemWithe,
                  height: 2,
                  color: _themeModel.themeColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
