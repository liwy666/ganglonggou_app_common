import 'package:json_annotation/json_annotation.dart';
import "indexAdItem.dart";
import "categoryItem.dart";
import "goodsItem.dart";
part 'indexInfo.g.dart';

@JsonSerializable()
class IndexInfo {
    IndexInfo();

    List<IndexAdItem> ad_list;
    List<CategoryItem> cat_list;
    List<GoodsItem> goods_list;
    
    factory IndexInfo.fromJson(Map<String,dynamic> json) => _$IndexInfoFromJson(json);
    Map<String, dynamic> toJson() => _$IndexInfoToJson(this);
}
