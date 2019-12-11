import 'package:json_annotation/json_annotation.dart';

part 'goodsInfo.g.dart';

@JsonSerializable()
class GoodsInfo {
    GoodsInfo();

    String goodsImg;
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
    
    factory GoodsInfo.fromJson(Map<String,dynamic> json) => _$GoodsInfoFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsInfoToJson(this);
}
