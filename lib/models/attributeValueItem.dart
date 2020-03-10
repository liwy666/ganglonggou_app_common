import 'package:json_annotation/json_annotation.dart';

part 'attributeValueItem.g.dart';

@JsonSerializable()
class AttributeValueItem {
    AttributeValueItem();

    String name;
    bool choiceFlag;
    
    factory AttributeValueItem.fromJson(Map<String,dynamic> json) => _$AttributeValueItemFromJson(json);
    Map<String, dynamic> toJson() => _$AttributeValueItemToJson(this);
}
