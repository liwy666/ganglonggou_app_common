// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'midOrderItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MidOrderItem _$MidOrderItemFromJson(Map<String, dynamic> json) {
  return MidOrderItem()
    ..id = json['id'] as num
    ..goods_id = json['goods_id'] as num
    ..goods_name = json['goods_name'] as String
    ..sku_desc = json['sku_desc'] as String
    ..mid_order_price = json['mid_order_price'] as String
    ..goods_number = json['goods_number'] as num
    ..give_integral = json['give_integral'] as num
    ..is_evaluate = json['is_evaluate'] as num
    ..img_url = json['img_url'] as String;
}

Map<String, dynamic> _$MidOrderItemToJson(MidOrderItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'goods_id': instance.goods_id,
      'goods_name': instance.goods_name,
      'sku_desc': instance.sku_desc,
      'mid_order_price': instance.mid_order_price,
      'goods_number': instance.goods_number,
      'give_integral': instance.give_integral,
      'is_evaluate': instance.is_evaluate,
      'img_url': instance.img_url
    };
