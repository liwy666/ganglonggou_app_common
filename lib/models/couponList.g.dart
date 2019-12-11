// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponList _$CouponListFromJson(Map<String, dynamic> json) {
  return CouponList()
    ..data = (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CouponItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CouponListToJson(CouponList instance) =>
    <String, dynamic>{'data': instance.data};
