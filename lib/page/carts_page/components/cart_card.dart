import 'package:flutter_app/common_import.dart';
import 'package:flutter_app/data_model/cart_data_model.dart';
import 'package:flutter_app/data_model/theme_model.dart';
import 'package:flutter_app/models/cartItem.dart';
import 'package:flutter_app/page/components/horizontal_goods_card.dart';
import 'package:flutter_app/page/components/my_stepper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartCard extends StatelessWidget {
  final CartItem cartItem;
  final CartDataModel cartDataModel;

  CartCard({@required this.cartItem, @required this.cartDataModel});

  @override
  Widget build(BuildContext context) {
    final _themeModel = Provider.of<ThemeModel>(context);
    // TODO: implement build
    return Card(
      color: _themeModel.pageBackgroundColor2,
      child: Stack(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Checkbox(
                  onChanged: (bool value) {
                    cartDataModel.switchCartChoiceState(
                        choiceState: value, cartInfo: cartItem);
                  },
                  value: cartItem.isChoice == 1 ? true : false,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  HorizontalGoodsCard(
                    goodsAttribute: cartItem.attrDesc,
                    goodsName: cartItem.goodsName,
                    goodsId: cartItem.isValid == 1 ? cartItem.goodsId : null,
                    goodsImg: cartItem.goodsAttributeImg,
                  ),
                  Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "￥${cartItem.goodsPrice.toStringAsFixed(2)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: ScreenUtil().setWidth(24),
                              fontWeight: FontWeight.w700,
                              color: Colors.red),
                        ),
                        Container(
                          child: MyStepper(
                            changeFunction: (int number) {
                              cartDataModel.updCartNumber(
                                  cartNumber: number, cartInfo: cartItem);
                            },
                            max: cartItem.goodsStock,
                            min: 1,
                            value: cartItem.goodsNumber,
                            size: MyStepperSize.small,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          cartItem.isValid == 0
              ? Positioned(
                  top: 25,
                  right: 50,
                  child: Transform.rotate(
                    angle: 0.35,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                        Text("失效",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: ScreenUtil().setWidth(24)))
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
