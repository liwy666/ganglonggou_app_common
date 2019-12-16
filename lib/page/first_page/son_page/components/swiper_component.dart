import 'package:extended_image/extended_image.dart';
import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/first_page_model.dart';
import 'package:flutter_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_app/page/components/my_extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class SwiperComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setWidth(290),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(SON_FIRST_PAGE_SWIPER_BACKGROUND_IMG_URL),
              fit: BoxFit.fitHeight)),
      child: Center(child: Consumer<IndexAdListDataModel>(
        builder: (context, IndexAdListDataModel indexAdListModel, _) {
          return Swiper(
            itemCount: indexAdListModel.swiperList.length,
            autoplay: true,
            onTap: (int index) {
              FirstPageModel.toControl(
                  indexAdItem: indexAdListModel.swiperList[index],
                  context: context);
            },
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: ScreenUtil().setWidth(690),
                      height: ScreenUtil().setWidth(280),
                      child: MyExtendedImage.network(
                        indexAdListModel.swiperList[index].ad_img,
                        fit: BoxFit.fill,
                      ),
                    )),
              );
            },
          );
        },
      )),
    );
  }
}
