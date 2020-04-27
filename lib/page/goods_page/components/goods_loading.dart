import 'package:flutter_skeleton/flutter_skeleton.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/components/my_tab_bar.dart';
import 'package:ganglong_shop_app/page/goods_page/components/goods_main.dart';
import 'package:ganglong_shop_app/page/goods_page/goods_page.dart';
import 'package:ganglong_shop_app/routes/application.dart';
import 'package:provider/provider.dart';

class GoodsLoading extends StatefulWidget {
  final double appWidth;
  final GoodsImgShowDirection goodsImgShowDirection;
  final String goodsImgUrl;
  final double topPadding;

  const GoodsLoading(
      {Key key,
      this.appWidth,
      this.goodsImgShowDirection,
      this.goodsImgUrl,
      this.topPadding})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GoodsLoading();
  }
}

class _GoodsLoading extends State<GoodsLoading>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    //图片宽高从0变到300
    animation = new Tween(begin: 0.0, end: widget.appWidth).animate(controller)
      ..addListener(() {
        setState(() => {});
      });
    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModel _themeModel = Provider.of<ThemeModel>(context);
    final List<Color> _colors =
        _themeModel.appThemeMode == AppThemeMode.defaultMode
            ? [
                Color(0xffecf0f1),
                Color(0xffbdc3c7),
                Color(0xffecf0f1),
              ]
            : [
                Color(0xff95a5a6),
                Color(0xff7f8c8d),
                Color(0xff95a5a6),
              ];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: _themeModel.pageBackgroundColor2,
          leading: GoodsLeftIcon(),
        ),
        backgroundColor: _themeModel.pageBackgroundColor1,
        body: Stack(
          children: <Widget>[
            widget.goodsImgShowDirection == GoodsImgShowDirection.right
                ? Positioned(
                    top: widget.appWidth - animation.value,
                    right: 0,
                    child: _GoodsImg(
                      boxWidth: animation.value,
                      boxHeight: animation.value,
                      imgUrl: widget.goodsImgUrl,
                      topPadding: widget.topPadding,
                    ),
                  )
                : Positioned(
                    top: widget.appWidth - animation.value,
                    left: 0,
                    child: _GoodsImg(
                      boxWidth: animation.value,
                      boxHeight: animation.value,
                      imgUrl: widget.goodsImgUrl,
                      topPadding: widget.topPadding,
                    ),
                  ),
            Positioned(
                top: widget.appWidth,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CardSkeleton(
                        style: SkeletonStyle(
                          padding: EdgeInsets.all(15),
                          backgroundColor: _themeModel.pageBackgroundColor1,
                          theme: _themeModel.appThemeMode ==
                                  AppThemeMode.defaultMode
                              ? SkeletonTheme.Light
                              : SkeletonTheme.Dark,
                          isShowAvatar: false,
                          isCircleAvatar: true,
                          colors: _colors,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          barCount: 4,
                          isAnimation: true,
                        ),
                      ),
                      CardSkeleton(
                        style: SkeletonStyle(
                          padding: EdgeInsets.all(15),
                          backgroundColor: _themeModel.pageBackgroundColor1,
                          theme: _themeModel.appThemeMode ==
                                  AppThemeMode.defaultMode
                              ? SkeletonTheme.Light
                              : SkeletonTheme.Dark,
                          isShowAvatar: false,
                          isCircleAvatar: false,
                          colors: _colors,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          barCount: 2,
                          isAnimation: true,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}

class _GoodsImg extends StatelessWidget {
  final double boxWidth;
  final double boxHeight;
  final double topPadding;
  final String imgUrl;

  const _GoodsImg(
      {Key key, this.boxWidth, this.boxHeight, this.imgUrl, this.topPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: boxWidth,
      height: boxHeight,
      child: MyExtendedImage.network(
        imgUrl,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
