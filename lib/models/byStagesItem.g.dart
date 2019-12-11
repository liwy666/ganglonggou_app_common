// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'byStagesItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ByStagesItem _$ByStagesItemFromJson(Map<String, dynamic> json) {
  return ByStagesItem()
    ..bystages_id = json['bystages_id'] as num
    ..pay_id = json['pay_id'] as num
    ..pay_code = json['pay_code'] as String
    ..bystages_val = json['bystages_val'] as String
    ..bystages_fee = json['bystages_fee'] as String
    ..bystages_stage = json['bystages_stage'] as num
    ..bystages_code = json['bystages_code'] as String
    ..bystages_cat_id = json['bystages_cat_id'] as num
    ..is_choice = json['is_choice'] as bool;
}

Map<String, dynamic> _$ByStagesItemToJson(ByStagesItem instance) =>
    <String, dynamic>{
      'bystages_id': instance.bystages_id,
      'pay_id': instance.pay_id,
      'pay_code': instance.pay_code,
      'bystages_val': instance.bystages_val,
      'bystages_fee': instance.bystages_fee,
      'bystages_stage': instance.bystages_stage,
      'bystages_code': instance.bystages_code,
      'bystages_cat_id': instance.bystages_cat_id,
      'is_choice': instance.is_choice
    };
