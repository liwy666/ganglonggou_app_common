// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressList _$AddressListFromJson(Map<String, dynamic> json) {
  return AddressList()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : AddressItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$AddressListToJson(AddressList instance) =>
    <String, dynamic>{'data': instance.data};
