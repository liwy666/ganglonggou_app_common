import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/read_order_page_model.dart';
import 'package:flutter_app/models/index.dart';
import 'package:flutter_app/page/components/horizontal_goods_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ReadOrderGoodsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<ReadOrderPageModel>(
      builder:
          (BuildContext context, ReadOrderPageModel readOrderPageModel, _) {
        return Container(
          child: Column(
            children: readOrderPageModel.orderInfo.mid_order
                .map<Widget>((MidOrderItem midOrderItem) {
              return HorizontalGoodsCard(
                goodsImg: midOrderItem.img_url,
                goodsName: midOrderItem.goods_name,
                goodsAttribute: midOrderItem.sku_desc,
                goodsId: midOrderItem.goods_id,
                goodsNumber: midOrderItem.goods_number,
                price: double.parse(midOrderItem.mid_order_price),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
