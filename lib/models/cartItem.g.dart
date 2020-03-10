// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem()
    ..cartId = json['cartId'] as num
    ..userId = json['userId'] as num
    ..goodsNumber = json['goodsNumber'] as num
    ..goodsSn = json['goodsSn'] as String
    ..goodsName = json['goodsName'] as String
    ..goodsId = json['goodsId'] as num
    ..catId = json['catId'] as num
    ..goodsHeadName = json['goodsHeadName'] as String
    ..goodsPrice = json['goodsPrice'] as num
    ..oneGoodsPrice = json['oneGoodsPrice'] as num
    ..marketPrice = json['marketPrice'] as num
    ..goodsStock = json['goodsStock'] as num
    ..goodsSalesVolume = json['goodsSalesVolume'] as num
    ..goodsAttributeImg = json['goodsAttributeImg'] as String
    ..skuId = json['skuId'] as num
    ..attrDesc = json['attrDesc'] as String
    ..isPromote = json['isPromote'] as num
    ..promoteNumber = json['promoteNumber'] as num
    ..promoteStartDate = json['promoteStartDate'] as num
    ..promoteEndDate = json['promoteEndDate'] as num
    ..giveIntegral = json['giveIntegral'] as num
    ..integral = json['integral'] as num
    ..oneGiveIntegral = json['oneGiveIntegral'] as num
    ..oneIntegral = json['oneIntegral'] as num
    ..integralDesc = json['integralDesc'] as String
    ..byStagesNumber = json['byStagesNumber'] as num
    ..isValid = json['isValid'] as num
    ..isChoice = json['isChoice'] as num;
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'cartId': instance.cartId,
      'userId': instance.userId,
      'goodsNumber': instance.goodsNumber,
      'goodsSn': instance.goodsSn,
      'goodsName': instance.goodsName,
      'goodsId': instance.goodsId,
      'catId': instance.catId,
      'goodsHeadName': instance.goodsHeadName,
      'goodsPrice': instance.goodsPrice,
      'oneGoodsPrice': instance.oneGoodsPrice,
      'marketPrice': instance.marketPrice,
      'goodsStock': instance.goodsStock,
      'goodsSalesVolume': instance.goodsSalesVolume,
      'goodsAttributeImg': instance.goodsAttributeImg,
      'skuId': instance.skuId,
      'attrDesc': instance.attrDesc,
      'isPromote': instance.isPromote,
      'promoteNumber': instance.promoteNumber,
      'promoteStartDate': instance.promoteStartDate,
      'promoteEndDate': instance.promoteEndDate,
      'giveIntegral': instance.giveIntegral,
      'integral': instance.integral,
      'oneGiveIntegral': instance.oneGiveIntegral,
      'oneIntegral': instance.oneIntegral,
      'integralDesc': instance.integralDesc,
      'byStagesNumber': instance.byStagesNumber,
      'isValid': instance.isValid,
      'isChoice': instance.isChoice
    };
