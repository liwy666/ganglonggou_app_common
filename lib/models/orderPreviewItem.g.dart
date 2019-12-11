// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderPreviewItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPreviewItem _$OrderPreviewItemFromJson(Map<String, dynamic> json) {
  return OrderPreviewItem()
    ..order_sn = json['order_sn'] as String
    ..order_state = json['order_state'] as num
    ..upd_time = json['upd_time'] as String
    ..order_state_name = json['order_state_name'] as String
    ..mid_order = (json['mid_order'] as List)
        ?.map((e) =>
            e == null ? null : MidOrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$OrderPreviewItemToJson(OrderPreviewItem instance) =>
    <String, dynamic>{
      'order_sn': instance.order_sn,
      'order_state': instance.order_state,
      'upd_time': instance.upd_time,
      'order_state_name': instance.order_state_name,
      'mid_order': instance.mid_order
    };
