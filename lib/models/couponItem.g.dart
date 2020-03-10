// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponItem _$CouponItemFromJson(Map<String, dynamic> json) {
  return CouponItem()
    ..coupon_id = json['coupon_id'] as num
    ..coupon_name = json['coupon_name'] as String
    ..coupon_desc = json['coupon_desc'] as String
    ..start_grant_time = json['start_grant_time'] as String
    ..end_grant_time = json['end_grant_time'] as String
    ..start_use_time = json['start_use_time'] as String
    ..end_use_time = json['end_use_time'] as String
    ..classify = json['classify'] as List
    ..solo = json['solo'] as List
    ..found_sum = json['found_sum'] as String
    ..cut_sum = json['cut_sum'] as String
    ..coupon_number = json['coupon_number'] as num
    ..coupon_remainder_number = json['coupon_remainder_number'] as num
    ..grant_type = json['grant_type'] as String;
}

Map<String, dynamic> _$CouponItemToJson(CouponItem instance) =>
    <String, dynamic>{
      'coupon_id': instance.coupon_id,
      'coupon_name': instance.coupon_name,
      'coupon_desc': instance.coupon_desc,
      'start_grant_time': instance.start_grant_time,
      'end_grant_time': instance.end_grant_time,
      'start_use_time': instance.start_use_time,
      'end_use_time': instance.end_use_time,
      'classify': instance.classify,
      'solo': instance.solo,
      'found_sum': instance.found_sum,
      'cut_sum': instance.cut_sum,
      'coupon_number': instance.coupon_number,
      'coupon_remainder_number': instance.coupon_remainder_number,
      'grant_type': instance.grant_type
    };
