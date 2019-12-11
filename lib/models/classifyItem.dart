import 'package:json_annotation/json_annotation.dart';

part 'classifyItem.g.dart';

@JsonSerializable()
class ClassifyItem {
    ClassifyItem();

    num id;
    String classify_name;
    String into_type;
    String click_type;
    num parent_id;
    num sort_order;
    String key_word;
    num goods_id;
    String logo_img;
    String bar_img;
    List<ClassifyItem> children;
    
    factory ClassifyItem.fromJson(Map<String,dynamic> json) => _$ClassifyItemFromJson(json);
    Map<String, dynamic> toJson() => _$ClassifyItemToJson(this);
}
