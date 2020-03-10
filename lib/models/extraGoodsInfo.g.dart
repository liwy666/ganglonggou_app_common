// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extraGoodsInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtraGoodsInfo _$ExtraGoodsInfoFromJson(Map<String, dynamic> json) {
  return ExtraGoodsInfo()
    ..goods_gallery = (json['goods_gallery'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsGalleryItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..goods_sku = (json['goods_sku'] as List)
        ?.map((e) =>
            e == null ? null : GoodsSkuItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..coupon_list = (json['coupon_list'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsCouponItem.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..supplier_preview_info = json['supplier_preview_info'] == null
        ? null
        : SupplierPreviewInfo.fromJson(
            json['supplier_preview_info'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ExtraGoodsInfoToJson(ExtraGoodsInfo instance) =>
    <String, dynamic>{
      'goods_gallery': instance.goods_gallery,
      'goods_sku': instance.goods_sku,
      'coupon_list': instance.coupon_list,
      'supplier_preview_info': instance.supplier_preview_info
    };
