// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsAttribute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsAttribute _$GoodsAttributeFromJson(Map<String, dynamic> json) {
  return GoodsAttribute()
    ..attribute_name = json['attribute_name'] as String
    ..attribute_value = json['attribute_value'] as List;
}

Map<String, dynamic> _$GoodsAttributeToJson(GoodsAttribute instance) =>
    <String, dynamic>{
      'attribute_name': instance.attribute_name,
      'attribute_value': instance.attribute_value
    };
