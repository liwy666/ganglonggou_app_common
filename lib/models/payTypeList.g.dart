// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payTypeList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayTypeList _$PayTypeListFromJson(Map<String, dynamic> json) {
  return PayTypeList()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : PayTypeItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$PayTypeListToJson(PayTypeList instance) =>
    <String, dynamic>{'data': instance.data};
