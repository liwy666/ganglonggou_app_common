// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goodsGalleryItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoodsGalleryItem _$GoodsGalleryItemFromJson(Map<String, dynamic> json) {
  return GoodsGalleryItem()
    ..goods_gallery_id = json['goods_gallery_id'] as num
    ..goods_id = json['goods_id'] as num
    ..img_url = json['img_url'] as String
    ..img_original = json['img_original'] as String;
}

Map<String, dynamic> _$GoodsGalleryItemToJson(GoodsGalleryItem instance) =>
    <String, dynamic>{
      'goods_gallery_id': instance.goods_gallery_id,
      'goods_id': instance.goods_id,
      'img_url': instance.img_url,
      'img_original': instance.img_original
    };
