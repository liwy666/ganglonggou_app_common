// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressOptionsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressOptionsItem _$AddressOptionsItemFromJson(Map<String, dynamic> json) {
  return AddressOptionsItem()
    ..value = json['value'] as String
    ..label = json['label'] as String
    ..children = (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : AddressOptionsItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AddressOptionsItemToJson(AddressOptionsItem instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'children': instance.children
    };
