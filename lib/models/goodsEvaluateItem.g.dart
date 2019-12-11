// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsEvaluateItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsEvaluateItem _$GoodsEvaluateItemFromJson(Map<String, dynamic> json) {
  return GoodsEvaluateItem()
    ..create_time = json['create_time'] as String
    ..parent_id = json['parent_id'] as num
    ..user_name = json['user_name'] as String
    ..user_img = json['user_img'] as String
    ..goods_name = json['goods_name'] as String
    ..sku_desc = json['sku_desc'] as String
    ..rate = json['rate'] as num
    ..evaluate_text = json['evaluate_text'] as String
    ..id = json['id'] as num;
}

Map<String, dynamic> _$GoodsEvaluateItemToJson(GoodsEvaluateItem instance) =>
    <String, dynamic>{
      'create_time': instance.create_time,
      'parent_id': instance.parent_id,
      'user_name': instance.user_name,
      'user_img': instance.user_img,
      'goods_name': instance.goods_name,
      'sku_desc': instance.sku_desc,
      'rate': instance.rate,
      'evaluate_text': instance.evaluate_text,
      'id': instance.id
    };
