import 'package:json_annotation/json_annotation.dart';
import "searchKeywordItem.dart";
part 'searchKeywordList.g.dart';

@JsonSerializable()
class SearchKeywordList {
    SearchKeywordList();

    List<SearchKeywordItem> data;
    
    factory SearchKeywordList.fromJson(Map<String,dynamic> json) => _$SearchKeywordListFromJson(json);
    Map<String, dynamic> toJson() => _$SearchKeywordListToJson(this);
}
