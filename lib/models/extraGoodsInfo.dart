import 'package:json_annotation/json_annotation.dart';
import "goodsGalleryItem.dart";
import "goodsSkuItem.dart";
import "goodsCouponItem.dart";
import "supplierPreviewInfo.dart";
part 'extraGoodsInfo.g.dart';

@JsonSerializable()
class ExtraGoodsInfo {
    ExtraGoodsInfo();

    List<GoodsGalleryItem> goods_gallery;
    List<GoodsSkuItem> goods_sku;
    List<GoodsCouponItem> coupon_list;
    SupplierPreviewInfo supplier_preview_info;
    
    factory ExtraGoodsInfo.fromJson(Map<String,dynamic> json) => _$ExtraGoodsInfoFromJson(json);
    Map<String, dynamic> toJson() => _$ExtraGoodsInfoToJson(this);
}
