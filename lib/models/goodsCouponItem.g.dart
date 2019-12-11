// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsCouponItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsCouponItem _$GoodsCouponItemFromJson(Map<String, dynamic> json) {
  return GoodsCouponItem()
    ..coupon_id = json['coupon_id'] as num
    ..coupon_name = json['coupon_name'] as String
    ..coupon_desc = json['coupon_desc'] as String
    ..start_grant_time = json['start_grant_time'] as String
    ..end_grant_time = json['end_grant_time'] as String
    ..start_use_time = json['start_use_time'] as String
    ..end_use_time = json['end_use_time'] as String
    ..found_sum = json['found_sum'] as String
    ..cut_sum = json['cut_sum'] as String
    ..coupon_number = json['coupon_number'] as num
    ..coupon_remainder_number = json['coupon_remainder_number'] as num
    ..grant_type = json['grant_type'] as String
    ..into_type = json['into_type'] as String
    ..is_del = json['is_del'] as num;
}

Map<String, dynamic> _$GoodsCouponItemToJson(GoodsCouponItem instance) =>
    <String, dynamic>{
      'coupon_id': instance.coupon_id,
      'coupon_name': instance.coupon_name,
      'coupon_desc': instance.coupon_desc,
      'start_grant_time': instance.start_grant_time,
      'end_grant_time': instance.end_grant_time,
      'start_use_time': instance.start_use_time,
      'end_use_time': instance.end_use_time,
      'found_sum': instance.found_sum,
      'cut_sum': instance.cut_sum,
      'coupon_number': instance.coupon_number,
      'coupon_remainder_number': instance.coupon_remainder_number,
      'grant_type': instance.grant_type,
      'into_type': instance.into_type,
      'is_del': instance.is_del
    };
