// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsEvaluateList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsEvaluateList _$GoodsEvaluateListFromJson(Map<String, dynamic> json) {
  return GoodsEvaluateList()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsEvaluateItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$GoodsEvaluateListToJson(GoodsEvaluateList instance) =>
    <String, dynamic>{'data': instance.data};
