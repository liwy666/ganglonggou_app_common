import 'package:json_annotation/json_annotation.dart';

part 'searchKeywordItem.g.dart';

@JsonSerializable()
class SearchKeywordItem {
    SearchKeywordItem();

    String search_keyword;
    
    factory SearchKeywordItem.fromJson(Map<String,dynamic> json) => _$SearchKeywordItemFromJson(json);
    Map<String, dynamic> toJson() => _$SearchKeywordItemToJson(this);
}
