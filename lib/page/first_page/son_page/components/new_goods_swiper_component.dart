import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/index_ad_list_data_model.dart';
import 'package:ganglong_shop_app/data_model/son_first_page_model.dart';
import 'package:ganglong_shop_app/data_model/theme_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/first_page/son_page/components/first_title_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class NewGoodsSwiperComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        FirstTitleComponent(
          textColor: Colors.red,
          firstText: "现货",
          lastText: "推荐",
          marginBottom: 0,
        ),
        Consumer2<SonFirstPageModel, IndexAdListDataModel>(
          builder: (context, SonFirstPageModel sonFirstPageModel,
              IndexAdListDataModel indexAdListDataModel, _) {
            return Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: sonFirstPageModel.newGoodsSwiperHeight,
                child: Swiper(
                  itemCount: indexAdListDataModel.newGoodsList.length,
                  onTap: (int index) {
                    FirstPageModel.toControl(
                        indexAdItem: indexAdListDataModel.newGoodsList[index],
                        context: context);
                  },
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: _NewGoodsSwiperComponentItem(
                        item: indexAdListDataModel.newGoodsList[index],
                        updateHeight: (double itemHeight) {
                          sonFirstPageModel
                              .updateNewGoodsSwiperHeight(itemHeight);
                        },
                        updateHeightFlag:
                            sonFirstPageModel.newGoodsSwiperUpdateHeightFlag,
                      ),
                    );
                  },
                  viewportFraction: 1/3,
                  scale: 1,
                ));
          },
        ),
      ],
    );
  }
}

class _NewGoodsSwiperComponentItem extends StatelessWidget {
  final IndexAdItem item;
  final Function updateHeight;
  bool updateHeightFlag;

  _NewGoodsSwiperComponentItem({
    Key key,
    @required this.item,
    @required this.updateHeight,
    @required this.updateHeightFlag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    if (updateHeightFlag) {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        updateHeight(context.size.height +5);
      });
    }

    // TODO: implement build
    return Card(
      margin: EdgeInsets.symmetric(vertical: 0,horizontal: 2),
      color:_themeModel.pageBackgroundColor2,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(200),
              child: MyExtendedImage.network(item.ad_img, fit: BoxFit.fitHeight),
            ),
            Container(
              margin: EdgeInsets.only(top:5),
              constraints: BoxConstraints(
                minWidth: double.infinity,
              ),
              child: Text(
                item.goods_name,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: _themeModel.fontColor1,
                  fontSize: COMMON_FONT_SIZE,
                ),
              ),
            ),
            Container(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "￥${item.goods_price}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: COMMON_FONT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                margin: EdgeInsets.only(top: 2),
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                child: Text(
                  "￥${item.origin_goods_price}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: _themeModel.fontColor2,
                      fontSize: SMALL_FONT_SIZE,
                      decoration: TextDecoration.lineThrough),
                )),
          ],
        ),
      ),
    );
  }
}
