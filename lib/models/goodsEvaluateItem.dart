import 'package:json_annotation/json_annotation.dart';

part 'goodsEvaluateItem.g.dart';

@JsonSerializable()
class GoodsEvaluateItem {
    GoodsEvaluateItem();

    String create_time;
    num parent_id;
    String user_name;
    String user_img;
    String goods_name;
    String sku_desc;
    num rate;
    String evaluate_text;
    num id;
    
    factory GoodsEvaluateItem.fromJson(Map<String,dynamic> json) => _$GoodsEvaluateItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsEvaluateItemToJson(this);
}
