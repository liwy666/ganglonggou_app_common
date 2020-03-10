// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payTypeItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayTypeItem _$PayTypeItemFromJson(Map<String, dynamic> json) {
  return PayTypeItem()
    ..pay_code = json['pay_code'] as String
    ..pay_name = json['pay_name'] as String
    ..pay_id = json['pay_id'] as num
    ..ByStages = (json['ByStages'] as List)
        ?.map((e) =>
            e == null ? null : ByStagesItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..is_choice = json['is_choice'] as bool;
}

Map<String, dynamic> _$PayTypeItemToJson(PayTypeItem instance) =>
    <String, dynamic>{
      'pay_code': instance.pay_code,
      'pay_name': instance.pay_name,
      'pay_id': instance.pay_id,
      'ByStages': instance.ByStages,
      'is_choice': instance.is_choice
    };
