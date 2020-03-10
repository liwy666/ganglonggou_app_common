import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/first_page_model.dart';
import 'package:ganglong_shop_app/data_model/index_ad_list_data_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class SwiperComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setWidth(300),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(SON_FIRST_PAGE_SWIPER_BACKGROUND_IMG_URL),
              fit: BoxFit.fitHeight)),
      child: Center(child: Consumer<IndexAdListDataModel>(
        builder: (context, IndexAdListDataModel indexAdListModel, _) {
          return indexAdListModel.swiperList.length > 1
              ? Swiper(
                  itemCount: indexAdListModel.swiperList.length,
                  autoplay: true,
                  onTap: (int index) {
                    FirstPageModel.toControl(
                        indexAdItem: indexAdListModel.swiperList[index],
                        context: context);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _ImgItem(
                      imgUrl: indexAdListModel.swiperList[index].ad_img,
                    );
                  },
                )
              : GestureDetector(
                  child: _ImgItem(
                    imgUrl: indexAdListModel.swiperList[0].ad_img,
                  ),
                  onTap: () {
                    FirstPageModel.toControl(
                        indexAdItem: indexAdListModel.swiperList[0],
                        context: context);
                  },
                );
        },
      )),
    );
  }
}

class _ImgItem extends StatelessWidget {
  final String imgUrl;

  const _ImgItem({Key key, @required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return imgUrl != null && imgUrl != ''
        ? Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              child: MyExtendedImage.network(
                imgUrl,
                fit: BoxFit.fitWidth,
              ),
            ),
          )
        : Container();
  }
}
