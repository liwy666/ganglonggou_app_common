// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsSkuOptionsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsSkuOptionsItem _$GoodsSkuOptionsItemFromJson(Map<String, dynamic> json) {
  return GoodsSkuOptionsItem()
    ..attributeName = json['attributeName'] as String
    ..attributeValue = (json['attributeValue'] as List)
        ?.map((e) => e == null
            ? null
            : AttributeValueItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodsSkuOptionsItemToJson(
        GoodsSkuOptionsItem instance) =>
    <String, dynamic>{
      'attributeName': instance.attributeName,
      'attributeValue': instance.attributeValue
    };
