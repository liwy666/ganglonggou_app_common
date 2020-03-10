import 'package:json_annotation/json_annotation.dart';

part 'searchLogItem.g.dart';

@JsonSerializable()
class SearchLogItem {
    SearchLogItem();

    num user_id;
    String search_keyword;
    
    factory SearchLogItem.fromJson(Map<String,dynamic> json) => _$SearchLogItemFromJson(json);
    Map<String, dynamic> toJson() => _$SearchLogItemToJson(this);
}
