import 'package:json_annotation/json_annotation.dart';
import "goodsEvaluateItem.dart";
part 'goodsEvaluateList.g.dart';

@JsonSerializable()
class GoodsEvaluateList {
    GoodsEvaluateList();

    List<GoodsEvaluateItem> data;
    
    factory GoodsEvaluateList.fromJson(Map<String,dynamic> json) => _$GoodsEvaluateListFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsEvaluateListToJson(this);
}
