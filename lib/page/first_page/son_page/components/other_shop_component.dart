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

class OtherShopComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        FirstTitleComponent(
          textColor: Colors.green,
          firstText: "平台",
          lastText: "店铺",
          marginBottom: 0,
        ),
        Consumer2<SonFirstPageModel, IndexAdListDataModel>(
          builder: (BuildContext context, SonFirstPageModel sonFirstPageModel,
              IndexAdListDataModel indexAdListDataModel, _) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: sonFirstPageModel.otherShopSwiperHeight,
              child: Swiper(
                itemCount: indexAdListDataModel.otherShopList.length,
                autoplay: true,
                onTap: (int index) {
                  FirstPageModel.toControl(
                      indexAdItem: indexAdListDataModel.otherShopList[index],
                      context: context);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                      child: _NewGoodsSwiperComponentItem(
                    item: indexAdListDataModel.otherShopList[index],
                    updateHeight: (double itemHeight) {
                      sonFirstPageModel.updateOtherShopSwiperHeight(itemHeight);
                    },
                    updateHeightFlag:
                        sonFirstPageModel.otherShopSwiperUpdateHeightFlag,
                  ));
                },
                viewportFraction: 1 / 3,
                scale: 1,
              ),
            );
          },
        )
      ],
    );
  }
}

class _NewGoodsSwiperComponentItem extends StatelessWidget {
  final IndexAdItem item;
  final Function updateHeight;
  bool updateHeightFlag;

  _NewGoodsSwiperComponentItem(
      {Key key,
      @required this.item,
      @required this.updateHeight,
      @required this.updateHeightFlag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    if (updateHeightFlag) {
      WidgetsBinding.instance.addPostFrameCallback((callback) {
        updateHeight(context.size.height + 5);
      });
    }

    // TODO: implement build
    return Card(
      color: _themeModel.pageBackgroundColor2,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    SON_FIRST_PAGE_OTHER_SHOP_ITEM_BACKGROUND_IMG_URL),
                fit: BoxFit.fill)),
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: ScreenUtil().setWidth(229),
              width: ScreenUtil().setWidth(229),
              child: MyExtendedImage.network(item.ad_img, fit: BoxFit.fill),
            ),
            Container(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  "${item.text}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                    color: _themeModel.pageBackgroundColor2,
                    fontSize: SMALL_FONT_SIZE,
                    //fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                constraints: BoxConstraints(
                  minWidth: double.infinity,
                ),
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "了解更多>",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _themeModel.pageBackgroundColor2,
                    fontSize: SMALL_FONT_SIZE,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
