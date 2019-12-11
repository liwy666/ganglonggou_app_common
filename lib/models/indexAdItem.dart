import 'package:json_annotation/json_annotation.dart';

part 'indexAdItem.g.dart';

@JsonSerializable()
class IndexAdItem {
    IndexAdItem();

    num id;
    String into_type;
    num click_count;
    String position_type;
    num is_on_sale;
    String position_type2;
    String position_type_name;
    String father_position_name;
    num sort_order;
    String ad_type;
    String ad_img;
    num goods_id;
    num cat_id;
    String url;
    String text;
    String goods_name;
    String goods_price;
    String origin_goods_price;
    
    factory IndexAdItem.fromJson(Map<String,dynamic> json) => _$IndexAdItemFromJson(json);
    Map<String, dynamic> toJson() => _$IndexAdItemToJson(this);
}
