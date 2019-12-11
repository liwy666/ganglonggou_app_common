// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsSkuItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsSkuItem _$GoodsSkuItemFromJson(Map<String, dynamic> json) {
  return GoodsSkuItem()
    ..sku_id = json['sku_id'] as num
    ..goods_id = json['goods_id'] as num
    ..sku_desc = json['sku_desc'] as String
    ..sku_stock = json['sku_stock'] as num
    ..sku_shop_price = json['sku_shop_price'] as String
    ..sku_market_price = json['sku_market_price'] as String
    ..give_integral = json['give_integral'] as num
    ..integral = json['integral'] as num
    ..img_url = json['img_url'] as String
    ..original_img_url = json['original_img_url'] as String;
}

Map<String, dynamic> _$GoodsSkuItemToJson(GoodsSkuItem instance) =>
    <String, dynamic>{
      'sku_id': instance.sku_id,
      'goods_id': instance.goods_id,
      'sku_desc': instance.sku_desc,
      'sku_stock': instance.sku_stock,
      'sku_shop_price': instance.sku_shop_price,
      'sku_market_price': instance.sku_market_price,
      'give_integral': instance.give_integral,
      'integral': instance.integral,
      'img_url': instance.img_url,
      'original_img_url': instance.original_img_url
    };
