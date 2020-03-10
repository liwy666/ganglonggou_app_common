// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classifyList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassifyList _$ClassifyListFromJson(Map<String, dynamic> json) {
  return ClassifyList()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ClassifyItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ClassifyListToJson(ClassifyList instance) =>
    <String, dynamic>{'data': instance.data};
