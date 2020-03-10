// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexAdItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexAdItem _$IndexAdItemFromJson(Map<String, dynamic> json) {
  return IndexAdItem()
    ..id = json['id'] as num
    ..into_type = json['into_type'] as String
    ..click_count = json['click_count'] as num
    ..position_type = json['position_type'] as String
    ..is_on_sale = json['is_on_sale'] as num
    ..position_type2 = json['position_type2'] as String
    ..position_type_name = json['position_type_name'] as String
    ..father_position_name = json['father_position_name'] as String
    ..sort_order = json['sort_order'] as num
    ..ad_type = json['ad_type'] as String
    ..ad_img = json['ad_img'] as String
    ..goods_id = json['goods_id'] as num
    ..cat_id = json['cat_id'] as num
    ..url = json['url'] as String
    ..text = json['text'] as String
    ..goods_name = json['goods_name'] as String
    ..goods_price = json['goods_price'] as String
    ..origin_goods_price = json['origin_goods_price'] as String;
}

Map<String, dynamic> _$IndexAdItemToJson(IndexAdItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'into_type': instance.into_type,
      'click_count': instance.click_count,
      'position_type': instance.position_type,
      'is_on_sale': instance.is_on_sale,
      'position_type2': instance.position_type2,
      'position_type_name': instance.position_type_name,
      'father_position_name': instance.father_position_name,
      'sort_order': instance.sort_order,
      'ad_type': instance.ad_type,
      'ad_img': instance.ad_img,
      'goods_id': instance.goods_id,
      'cat_id': instance.cat_id,
      'url': instance.url,
      'text': instance.text,
      'goods_name': instance.goods_name,
      'goods_price': instance.goods_price,
      'origin_goods_price': instance.origin_goods_price
    };
