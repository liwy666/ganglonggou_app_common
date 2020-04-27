import 'package:ganglong_shop_app/common_import.dart';
import 'package:ganglong_shop_app/data_model/goods_model.dart';
import 'package:ganglong_shop_app/page/components/my_dialog.dart';
import 'package:ganglong_shop_app/page/components/my_list_tile.dart';

import 'goods_sku_dialog.dart';

class GoodsSkuPreview extends StatelessWidget {
  final GoodsModel goodsModel;

  GoodsSkuPreview({@required this.goodsModel});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MyListTile(
      titleWidget: Text('已选'),
      subtitleWidget: Text(
          '${goodsModel.goodsInfo.attrDesc},${goodsModel.goodsInfo.goodsNumber}件'),
      onTapFunction: () {
        MyDialog().showBottomDialog(
            context: context,
            child: GoodsSkuDiaLog(
              clickType: SkuButtonClickType.addShoppingCart,
            ));
      },
    );
  }
}