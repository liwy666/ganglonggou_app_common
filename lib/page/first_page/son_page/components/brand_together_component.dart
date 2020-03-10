import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/index_ad_list_data_model.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:ganglong_shop_app/page/first_page/son_page/components/first_title_component.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BrandTogetherComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          FirstTitleComponent(
              textColor: Colors.blue, firstText: "品牌", lastText: "惠聚",marginTop: 0,),
          Center(
            child: Container(
              child: Consumer<IndexAdListDataModel>(
                builder: (BuildContext context,
                    IndexAdListDataModel indexAdList, _) {
                  return indexAdList.brandTogetherList.length == 7
                      ? _SevenBrandBox(
                          brandTogetherList: indexAdList.brandTogetherList)
                      : _NineBrandBox(
                          brandTogetherList: indexAdList.brandTogetherList,
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NineBrandBox extends StatelessWidget {
  final List<IndexAdItem> brandTogetherList;

  const _NineBrandBox({Key key, @required this.brandTogetherList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Wrap(
        spacing: 5.0, // 主轴(水平)方向间距
        runSpacing: 5.0, // 纵轴（垂直）方向间距
        children: brandTogetherList.map((IndexAdItem item) {
          return _CommonBrandBox(
            item: item,
          );
        }).toList(),
      ),
    );
  }
}

class _SevenBrandBox extends StatelessWidget {
  final List<IndexAdItem> brandTogetherList;

  const _SevenBrandBox({Key key, this.brandTogetherList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int i = 0;
    // TODO: implement build
    return Container(
      width: ScreenUtil().setWidth(700),
      height: ScreenUtil().setWidth(780),
      child: Wrap(
        spacing: ScreenUtil().setWidth(10),
        runSpacing: ScreenUtil().setWidth(15),
        children: brandTogetherList.map((IndexAdItem item) {
          Widget brandBox;
          if (i == 0 || i == 6) {
            brandBox = _LongBrandBox(item: item);
          } else {
            brandBox = _ShortBrandBox(item: item);
          }
          i++;
          return brandBox;
        }).toList(),
      ),
    );
  }
}

class _LongBrandBox extends StatelessWidget {
  final IndexAdItem item;

  _LongBrandBox({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RADIUS_COMMON_VALUE),
        child: Container(
          width: ScreenUtil().setWidth(458),
          height: ScreenUtil().setWidth(251),
          child: MyExtendedImage.network(
            item.ad_img,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: item, context: context);
      },
    );
  }
}

class _ShortBrandBox extends StatelessWidget {
  final IndexAdItem item;

  _ShortBrandBox({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RADIUS_COMMON_VALUE),
        child: Container(
          width: ScreenUtil().setWidth(226),
          height: ScreenUtil().setWidth(251),
          child: MyExtendedImage.network(
            item.ad_img,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: item, context: context);
      },
    );
  }
}

class _CommonBrandBox extends StatelessWidget {
  final IndexAdItem item;

  _CommonBrandBox({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RADIUS_COMMON_VALUE),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.95 * 0.48,
          child: MyExtendedImage.network(
            item.ad_img,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: item, context: context);
      },
    );
  }
}
