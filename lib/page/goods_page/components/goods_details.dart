import 'package:extended_image/extended_image.dart';
import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/page/components/my_extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class GoodsDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<GoodsModel>(
      builder: (BuildContext context, GoodsModel goodsModel, _) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.only(
                    bottom: index + 1 == goodsModel.goodsDetails.length
                        ? ScreenUtil().setWidth(100)
                        : 0),
                child: MyExtendedImage.network(
                  goodsModel.goodsDetails[index],
                  fit: BoxFit.fitWidth,
                ),
              );
            },
            childCount: goodsModel.goodsDetails.length,
          ),
        );
      },
    );
  }
}
