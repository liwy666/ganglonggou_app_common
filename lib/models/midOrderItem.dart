import 'package:json_annotation/json_annotation.dart';

part 'midOrderItem.g.dart';

@JsonSerializable()
class MidOrderItem {
    MidOrderItem();

    num id;
    num goods_id;
    String goods_name;
    String sku_desc;
    String mid_order_price;
    num goods_number;
    num give_integral;
    num is_evaluate;
    String img_url;
    
    factory MidOrderItem.fromJson(Map<String,dynamic> json) => _$MidOrderItemFromJson(json);
    Map<String, dynamic> toJson() => _$MidOrderItemToJson(this);
}
