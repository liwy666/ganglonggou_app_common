import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/page/components/horizontal_goods_card.dart';
import 'package:provider/provider.dart';

class WriteOrderGoodsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<CartDataModel>(
      builder: (BuildContext context, CartDataModel cartDataModel, _) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                cartDataModel.selectionCartList.map<Widget>((CartItem item) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: HorizontalGoodsCard(
                  goodsImg: item.goodsAttributeImg,
                  goodsAttribute: item.attrDesc,
                  goodsName: item.goodsName,
                  price: (item.goodsPrice is double)
                      ? item.goodsPrice
                      : double.parse(item.goodsPrice.toString()),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
