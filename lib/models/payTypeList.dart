import 'package:json_annotation/json_annotation.dart';
import "payTypeItem.dart";
part 'payTypeList.g.dart';

@JsonSerializable()
class PayTypeList {
    PayTypeList();

    List<PayTypeItem> data;
    
    factory PayTypeList.fromJson(Map<String,dynamic> json) => _$PayTypeListFromJson(json);
    Map<String, dynamic> toJson() => _$PayTypeListToJson(this);
}
