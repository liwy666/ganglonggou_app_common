import 'package:json_annotation/json_annotation.dart';

part 'categoryItem.g.dart';

@JsonSerializable()
class CategoryItem {
    CategoryItem();

    num cat_id;
    String cat_name;
    num sort_order;
    
    factory CategoryItem.fromJson(Map<String,dynamic> json) => _$CategoryItemFromJson(json);
    Map<String, dynamic> toJson() => _$CategoryItemToJson(this);
}
