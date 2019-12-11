// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplierPreviewInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplierPreviewInfo _$SupplierPreviewInfoFromJson(Map<String, dynamic> json) {
  return SupplierPreviewInfo()
    ..id = json['id'] as num
    ..supplier_name = json['supplier_name'] as String
    ..company_name = json['company_name'] as String
    ..service_tel = json['service_tel'] as String
    ..after_sale_tel = json['after_sale_tel'] as String
    ..describe_rate = json['describe_rate'] as String
    ..service_rate = json['service_rate'] as String
    ..logistics_rate = json['logistics_rate'] as String
    ..follow_number = json['follow_number'] as num
    ..colour = json['colour'] as String
    ..logo_img = json['logo_img'] as String
    ..head_img = json['head_img'] as String
    ..goods_list = (json['goods_list'] as List)
        ?.map((e) =>
            e == null ? null : GoodsItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SupplierPreviewInfoToJson(
        SupplierPreviewInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'supplier_name': instance.supplier_name,
      'company_name': instance.company_name,
      'service_tel': instance.service_tel,
      'after_sale_tel': instance.after_sale_tel,
      'describe_rate': instance.describe_rate,
      'service_rate': instance.service_rate,
      'logistics_rate': instance.logistics_rate,
      'follow_number': instance.follow_number,
      'colour': instance.colour,
      'logo_img': instance.logo_img,
      'head_img': instance.head_img,
      'goods_list': instance.goods_list
    };
