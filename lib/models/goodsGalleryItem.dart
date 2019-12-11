import 'package:json_annotation/json_annotation.dart';

part 'goodsGalleryItem.g.dart';

@JsonSerializable()
class GoodsGalleryItem {
    GoodsGalleryItem();

    num goods_gallery_id;
    num goods_id;
    String img_url;
    String img_original;
    
    factory GoodsGalleryItem.fromJson(Map<String,dynamic> json) => _$GoodsGalleryItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsGalleryItemToJson(this);
}
