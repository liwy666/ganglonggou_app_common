import 'package:json_annotation/json_annotation.dart';
import "byStagesItem.dart";
part 'payTypeItem.g.dart';

@JsonSerializable()
class PayTypeItem {
    PayTypeItem();

    String pay_code;
    String pay_name;
    num pay_id;
    List<ByStagesItem> ByStages;
    bool is_choice;
    
    factory PayTypeItem.fromJson(Map<String,dynamic> json) => _$PayTypeItemFromJson(json);
    Map<String, dynamic> toJson() => _$PayTypeItemToJson(this);
}
