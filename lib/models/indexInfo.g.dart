// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indexInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndexInfo _$IndexInfoFromJson(Map<String, dynamic> json) {
  return IndexInfo()
    ..ad_list = (json['ad_list'] as List)
        ?.map((e) =>
            e == null ? null : IndexAdItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..cat_list = (json['cat_list'] as List)
        ?.map((e) =>
            e == null ? null : CategoryItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..goods_list = (json['goods_list'] as List)
        ?.map((e) =>
            e == null ? null : GoodsItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$IndexInfoToJson(IndexInfo instance) => <String, dynamic>{
      'ad_list': instance.ad_list,
      'cat_list': instance.cat_list,
      'goods_list': instance.goods_list
    };
