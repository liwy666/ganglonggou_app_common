import 'package:json_annotation/json_annotation.dart';
import "attributeValueItem.dart";
part 'goodsSkuOptionsItem.g.dart';

@JsonSerializable()
class GoodsSkuOptionsItem {
    GoodsSkuOptionsItem();

    String attributeName;
    List<AttributeValueItem> attributeValue;
    
    factory GoodsSkuOptionsItem.fromJson(Map<String,dynamic> json) => _$GoodsSkuOptionsItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsSkuOptionsItemToJson(this);
}
