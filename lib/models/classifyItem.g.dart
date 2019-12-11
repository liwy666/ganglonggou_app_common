// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifyItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassifyItem _$ClassifyItemFromJson(Map<String, dynamic> json) {
  return ClassifyItem()
    ..id = json['id'] as num
    ..classify_name = json['classify_name'] as String
    ..into_type = json['into_type'] as String
    ..click_type = json['click_type'] as String
    ..parent_id = json['parent_id'] as num
    ..sort_order = json['sort_order'] as num
    ..key_word = json['key_word'] as String
    ..goods_id = json['goods_id'] as num
    ..logo_img = json['logo_img'] as String
    ..bar_img = json['bar_img'] as String
    ..children = (json['children'] as List)
        ?.map((e) =>
            e == null ? null : ClassifyItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ClassifyItemToJson(ClassifyItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'classify_name': instance.classify_name,
      'into_type': instance.into_type,
      'click_type': instance.click_type,
      'parent_id': instance.parent_id,
      'sort_order': instance.sort_order,
      'key_word': instance.key_word,
      'goods_id': instance.goods_id,
      'logo_img': instance.logo_img,
      'bar_img': instance.bar_img,
      'children': instance.children
    };
