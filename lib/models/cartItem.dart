import 'package:json_annotation/json_annotation.dart';

part 'cartItem.g.dart';

@JsonSerializable()
class CartItem {
    CartItem();

    num cartId;
    num userId;
    num goodsNumber;
    String goodsSn;
    String goodsName;
    num goodsId;
    num catId;
    String goodsHeadName;
    num goodsPrice;
    num oneGoodsPrice;
    num marketPrice;
    num goodsStock;
    num goodsSalesVolume;
    String goodsAttributeImg;
    num skuId;
    String attrDesc;
    num isPromote;
    num promoteNumber;
    num promoteStartDate;
    num promoteEndDate;
    num giveIntegral;
    num integral;
    num oneGiveIntegral;
    num oneIntegral;
    String integralDesc;
    num byStagesNumber;
    num isValid;
    num isChoice;
    
    factory CartItem.fromJson(Map<String,dynamic> json) => _$CartItemFromJson(json);
    Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
