import 'package:json_annotation/json_annotation.dart';
import "midOrderItem.dart";
part 'orderPreviewItem.g.dart';

@JsonSerializable()
class OrderPreviewItem {
    OrderPreviewItem();

    String order_sn;
    num order_state;
    String upd_time;
    String order_state_name;
    List<MidOrderItem> mid_order;
    
    factory OrderPreviewItem.fromJson(Map<String,dynamic> json) => _$OrderPreviewItemFromJson(json);
    Map<String, dynamic> toJson() => _$OrderPreviewItemToJson(this);
}
