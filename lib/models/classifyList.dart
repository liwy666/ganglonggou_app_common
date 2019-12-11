import 'package:json_annotation/json_annotation.dart';
import "classifyItem.dart";
part 'classifyList.g.dart';

@JsonSerializable()
class ClassifyList {
    ClassifyList();

    List<ClassifyItem> data;
    
    factory ClassifyList.fromJson(Map<String,dynamic> json) => _$ClassifyListFromJson(json);
    Map<String, dynamic> toJson() => _$ClassifyListToJson(this);
}
