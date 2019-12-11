import 'package:json_annotation/json_annotation.dart';

part 'goodsAttribute.g.dart';

@JsonSerializable()
class GoodsAttribute {
    GoodsAttribute();

    String attribute_name;
    List attribute_value;
    
    factory GoodsAttribute.fromJson(Map<String,dynamic> json) => _$GoodsAttributeFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsAttributeToJson(this);
}
