import 'package:json_annotation/json_annotation.dart';
import "addressOptionsItem.dart";
part 'addressOptionsList.g.dart';

@JsonSerializable()
class AddressOptionsList {
    AddressOptionsList();

    List<AddressOptionsItem> data;
    
    factory AddressOptionsList.fromJson(Map<String,dynamic> json) => _$AddressOptionsListFromJson(json);
    Map<String, dynamic> toJson() => _$AddressOptionsListToJson(this);
}
