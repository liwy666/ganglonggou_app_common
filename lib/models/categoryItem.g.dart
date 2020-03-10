// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItem _$CategoryItemFromJson(Map<String, dynamic> json) {
  return CategoryItem()
    ..cat_id = json['cat_id'] as num
    ..cat_name = json['cat_name'] as String
    ..sort_order = json['sort_order'] as num;
}

Map<String, dynamic> _$CategoryItemToJson(CategoryItem instance) =>
    <String, dynamic>{
      'cat_id': instance.cat_id,
      'cat_name': instance.cat_name,
      'sort_order': instance.sort_order
    };
