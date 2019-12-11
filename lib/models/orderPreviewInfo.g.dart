// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderPreviewInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPreviewInfo _$OrderPreviewInfoFromJson(Map<String, dynamic> json) {
  return OrderPreviewInfo()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : OrderPreviewItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderPreviewInfoToJson(OrderPreviewInfo instance) =>
    <String, dynamic>{'data': instance.data};
