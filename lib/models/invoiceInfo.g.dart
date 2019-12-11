// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoiceInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceInfo _$InvoiceInfoFromJson(Map<String, dynamic> json) {
  return InvoiceInfo()
    ..invoice_type = json['invoice_type'] as String
    ..invoice_head = json['invoice_head'] as String
    ..invoice_phone = json['invoice_phone'] as String
    ..invoice_qymc = json['invoice_qymc'] as String
    ..invoice_nsrsbh = json['invoice_nsrsbh'] as String
    ..invoice_kpdz = json['invoice_kpdz'] as String
    ..invoice_zj = json['invoice_zj'] as String
    ..invoice_khh = json['invoice_khh'] as String
    ..invoice_yhzh = json['invoice_yhzh'] as String;
}

Map<String, dynamic> _$InvoiceInfoToJson(InvoiceInfo instance) =>
    <String, dynamic>{
      'invoice_type': instance.invoice_type,
      'invoice_head': instance.invoice_head,
      'invoice_phone': instance.invoice_phone,
      'invoice_qymc': instance.invoice_qymc,
      'invoice_nsrsbh': instance.invoice_nsrsbh,
      'invoice_kpdz': instance.invoice_kpdz,
      'invoice_zj': instance.invoice_zj,
      'invoice_khh': instance.invoice_khh,
      'invoice_yhzh': instance.invoice_yhzh
    };
