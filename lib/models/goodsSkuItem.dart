import 'package:json_annotation/json_annotation.dart';

part 'goodsSkuItem.g.dart';

@JsonSerializable()
class GoodsSkuItem {
    GoodsSkuItem();

    num sku_id;
    num goods_id;
    String sku_desc;
    num sku_stock;
    String sku_shop_price;
    String sku_market_price;
    num give_integral;
    num integral;
    String img_url;
    String original_img_url;
    
    factory GoodsSkuItem.fromJson(Map<String,dynamic> json) => _$GoodsSkuItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsSkuItemToJson(this);
}
