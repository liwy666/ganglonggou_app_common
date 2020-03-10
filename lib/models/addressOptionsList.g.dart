// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressOptionsList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressOptionsList _$AddressOptionsListFromJson(Map<String, dynamic> json) {
  return AddressOptionsList()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AddressOptionsItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AddressOptionsListToJson(AddressOptionsList instance) =>
    <String, dynamic>{'data': instance.data};
