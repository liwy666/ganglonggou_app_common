// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsItem _$GoodsItemFromJson(Map<String, dynamic> json) {
  return GoodsItem()
    ..goods_id = json['goods_id'] as num
    ..cat_id = json['cat_id'] as num
    ..goods_sn = json['goods_sn'] as String
    ..goods_name = json['goods_name'] as String
    ..goods_head_name = json['goods_head_name'] as String
    ..market_price = json['market_price'] as String
    ..shop_price = json['shop_price'] as String
    ..keywords = json['keywords'] as String
    ..goods_brief = json['goods_brief'] as String
    ..goods_desc = json['goods_desc'] as String
    ..goods_stock = json['goods_stock'] as num
    ..goods_img = json['goods_img'] as String
    ..original_img = json['original_img'] as String
    ..sort_order = json['sort_order'] as num
    ..goods_sales_volume = json['goods_sales_volume'] as num
    ..evaluate_count = json['evaluate_count'] as num
    ..attribute = (json['attribute'] as List)
        ?.map((e) => e == null
            ? null
            : GoodsAttribute.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..is_promote = json['is_promote'] as num
    ..promote_number = json['promote_number'] as num
    ..promote_start_date = json['promote_start_date'] as num
    ..promote_end_date = json['promote_end_date'] as num
    ..supplier_id = json['supplier_id'] as num
    ..supplier_name = json['supplier_name'] as String
    ..add_time = json['add_time'] as num
    ..cat_name = json['cat_name'] as String;
}

Map<String, dynamic> _$GoodsItemToJson(GoodsItem instance) => <String, dynamic>{
      'goods_id': instance.goods_id,
      'cat_id': instance.cat_id,
      'goods_sn': instance.goods_sn,
      'goods_name': instance.goods_name,
      'goods_head_name': instance.goods_head_name,
      'market_price': instance.market_price,
      'shop_price': instance.shop_price,
      'keywords': instance.keywords,
      'goods_brief': instance.goods_brief,
      'goods_desc': instance.goods_desc,
      'goods_stock': instance.goods_stock,
      'goods_img': instance.goods_img,
      'original_img': instance.original_img,
      'sort_order': instance.sort_order,
      'goods_sales_volume': instance.goods_sales_volume,
      'evaluate_count': instance.evaluate_count,
      'attribute': instance.attribute,
      'is_promote': instance.is_promote,
      'promote_number': instance.promote_number,
      'promote_start_date': instance.promote_start_date,
      'promote_end_date': instance.promote_end_date,
      'supplier_id': instance.supplier_id,
      'supplier_name': instance.supplier_name,
      'add_time': instance.add_time,
      'cat_name': instance.cat_name
    };
