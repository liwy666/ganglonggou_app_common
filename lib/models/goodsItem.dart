import 'package:json_annotation/json_annotation.dart';
import "goodsAttribute.dart";
part 'goodsItem.g.dart';

@JsonSerializable()
class GoodsItem {
    GoodsItem();

    num goods_id;
    num cat_id;
    String goods_sn;
    String goods_name;
    String goods_head_name;
    String market_price;
    String shop_price;
    String keywords;
    String goods_brief;
    String goods_desc;
    num goods_stock;
    String goods_img;
    String original_img;
    num sort_order;
    num goods_sales_volume;
    num evaluate_count;
    List<GoodsAttribute> attribute;
    num is_promote;
    num promote_number;
    num promote_start_date;
    num promote_end_date;
    num supplier_id;
    String supplier_name;
    num add_time;
    String cat_name;
    
    factory GoodsItem.fromJson(Map<String,dynamic> json) => _$GoodsItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsItemToJson(this);
}
