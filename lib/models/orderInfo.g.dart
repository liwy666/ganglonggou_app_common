// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInfo _$OrderInfoFromJson(Map<String, dynamic> json) {
  return OrderInfo()
    ..order_sn = json['order_sn'] as String
    ..user_id = json['user_id'] as num
    ..user_name = json['user_name'] as String
    ..order_state = json['order_state'] as num
    ..original_order_price = json['original_order_price'] as String
    ..after_using_coupon_price = json['after_using_coupon_price'] as String
    ..after_using_integral_price = json['after_using_integral_price'] as String
    ..after_using_pay_price = json['after_using_pay_price'] as String
    ..order_price = json['order_price'] as String
    ..give_integral = json['give_integral'] as num
    ..pay_name = json['pay_name'] as String
    ..pay_code = json['pay_code'] as String
    ..bystages_val = json['bystages_val'] as String
    ..create_time = json['create_time'] as String
    ..upd_time = json['upd_time'] as String
    ..invalid_pay_time = json['invalid_pay_time'] as num
    ..logistics_name = json['logistics_name'] as String
    ..logistics_tel = json['logistics_tel'] as String
    ..logistics_address = json['logistics_address'] as String
    ..logistics_code = json['logistics_code'] as String
    ..logistics_sn = json['logistics_sn'] as String
    ..pay_time = json['pay_time'] as String
    ..deliver_goods_time = json['deliver_goods_time'] as String
    ..sign_goods_time = json['sign_goods_time'] as String
    ..invalid_sign_goods_time = json['invalid_sign_goods_time'] as String
    ..order_visible_note = json['order_visible_note'] as String
    ..son_into_type = json['son_into_type'] as String
    ..order_state_name = json['order_state_name'] as String
    ..logistics_code_name = json['logistics_code_name'] as String
    ..mid_order = (json['mid_order'] as List)
        ?.map((e) =>
            e == null ? null : MidOrderItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..invoice = json['invoice'] == null
        ? null
        : InvoiceInfo.fromJson(json['invoice'] as Map<String, dynamic>);
}

Map<String, dynamic> _$OrderInfoToJson(OrderInfo instance) => <String, dynamic>{
      'order_sn': instance.order_sn,
      'user_id': instance.user_id,
      'user_name': instance.user_name,
      'order_state': instance.order_state,
      'original_order_price': instance.original_order_price,
      'after_using_coupon_price': instance.after_using_coupon_price,
      'after_using_integral_price': instance.after_using_integral_price,
      'after_using_pay_price': instance.after_using_pay_price,
      'order_price': instance.order_price,
      'give_integral': instance.give_integral,
      'pay_name': instance.pay_name,
      'pay_code': instance.pay_code,
      'bystages_val': instance.bystages_val,
      'create_time': instance.create_time,
      'upd_time': instance.upd_time,
      'invalid_pay_time': instance.invalid_pay_time,
      'logistics_name': instance.logistics_name,
      'logistics_tel': instance.logistics_tel,
      'logistics_address': instance.logistics_address,
      'logistics_code': instance.logistics_code,
      'logistics_sn': instance.logistics_sn,
      'pay_time': instance.pay_time,
      'deliver_goods_time': instance.deliver_goods_time,
      'sign_goods_time': instance.sign_goods_time,
      'invalid_sign_goods_time': instance.invalid_sign_goods_time,
      'order_visible_note': instance.order_visible_note,
      'son_into_type': instance.son_into_type,
      'order_state_name': instance.order_state_name,
      'logistics_code_name': instance.logistics_code_name,
      'mid_order': instance.mid_order,
      'invoice': instance.invoice
    };
