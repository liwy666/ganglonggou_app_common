import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ganglong_shop_app/models/index.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:provider/provider.dart';

class SolitaryBannerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Consumer<IndexAdListDataModel>(
          builder: ((context, IndexAdListDataModel indexAdList, _) {
        return Container(
          margin: EdgeInsets.only(top: 5),
          child: indexAdList.lonelyBanner.length == 1
              ? _OneBanner(indexAdItem: indexAdList.lonelyBanner[0])
              : _ManyBanner(
                  indexAdList: indexAdList.lonelyBanner,
                ),
        );
      })),
    );
  }
}

class _OneBanner extends StatelessWidget {
  final IndexAdItem indexAdItem;

  const _OneBanner({Key key, @required this.indexAdItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RADIUS_COMMON_VALUE),
        child: Image(
          width: MediaQuery.of(context).size.width * 0.95,
          image: NetworkImage(indexAdItem.ad_img),
          fit: BoxFit.fitWidth,
        ),
      ),
      onTap: () {
        FirstPageModel.toControl(indexAdItem: indexAdItem, context: context);
      },
    );
  }
}

class _ManyBanner extends StatelessWidget {
  final List<IndexAdItem> indexAdList;

  const _ManyBanner({Key key, @required this.indexAdList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Wrap(
          spacing: 5,
          children: indexAdList.map((IndexAdItem indexAdItem) {
            return GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(RADIUS_COMMON_VALUE),
                child: MyExtendedImage.network(
                  indexAdItem.ad_img,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 0.95 * 0.49,
                ),
              ),
            );
          }).toList()),
    );
  }
}
