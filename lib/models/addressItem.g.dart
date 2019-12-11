// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addressItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressItem _$AddressItemFromJson(Map<String, dynamic> json) {
  return AddressItem()
    ..address_id = json['address_id'] as num
    ..user_id = json['user_id'] as num
    ..name = json['name'] as String
    ..tel = json['tel'] as String
    ..province = json['province'] as String
    ..city = json['city'] as String
    ..county = json['county'] as String
    ..area_code = json['area_code'] as String
    ..address_detail = json['address_detail'] as String
    ..is_default = json['is_default'] as num;
}

Map<String, dynamic> _$AddressItemToJson(AddressItem instance) =>
    <String, dynamic>{
      'address_id': instance.address_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'tel': instance.tel,
      'province': instance.province,
      'city': instance.city,
      'county': instance.county,
      'area_code': instance.area_code,
      'address_detail': instance.address_detail,
      'is_default': instance.is_default
    };
