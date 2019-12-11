import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/first_page_model.dart';
import 'package:flutter_app/data_model/index_ad_list_data_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SolitaryBannerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setWidth(190),
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Consumer<IndexAdListDataModel>(
            builder: ((context, IndexAdListDataModel indexAdList, _) {
          return GestureDetector(
            child: Container(
              child: Image(
                image: NetworkImage(indexAdList.lonelyBanner.ad_img),
                width: MediaQuery.of(context).size.width,
              ),
            ),
            onTap: () {
              FirstPageModel.toControl(
                  indexAdItem: indexAdList.lonelyBanner, context: context);
            },
          );
        })),
      ),
    );
  }
}
