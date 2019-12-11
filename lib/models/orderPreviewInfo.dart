import 'package:json_annotation/json_annotation.dart';
import "orderPreviewItem.dart";
part 'orderPreviewInfo.g.dart';

@JsonSerializable()
class OrderPreviewInfo {
    OrderPreviewInfo();

    List<OrderPreviewItem> data;
    
    factory OrderPreviewInfo.fromJson(Map<String,dynamic> json) => _$OrderPreviewInfoFromJson(json);
    Map<String, dynamic> toJson() => _$OrderPreviewInfoToJson(this);
}
