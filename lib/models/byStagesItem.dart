import 'package:json_annotation/json_annotation.dart';

part 'byStagesItem.g.dart';

@JsonSerializable()
class ByStagesItem {
    ByStagesItem();

    num bystages_id;
    num pay_id;
    String pay_code;
    String bystages_val;
    String bystages_fee;
    num bystages_stage;
    String bystages_code;
    num bystages_cat_id;
    bool is_choice;
    
    factory ByStagesItem.fromJson(Map<String,dynamic> json) => _$ByStagesItemFromJson(json);
    Map<String, dynamic> toJson() => _$ByStagesItemToJson(this);
}
