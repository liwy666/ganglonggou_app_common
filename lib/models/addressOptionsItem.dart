import 'package:json_annotation/json_annotation.dart';

part 'addressOptionsItem.g.dart';

@JsonSerializable()
class AddressOptionsItem {
    AddressOptionsItem();

    String value;
    String label;
    List<AddressOptionsItem> children;
    
    factory AddressOptionsItem.fromJson(Map<String,dynamic> json) => _$AddressOptionsItemFromJson(json);
    Map<String, dynamic> toJson() => _$AddressOptionsItemToJson(this);
}
