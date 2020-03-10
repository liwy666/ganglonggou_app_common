import 'package:json_annotation/json_annotation.dart';

part 'addressItem.g.dart';

@JsonSerializable()
class AddressItem {
    AddressItem();

    num address_id;
    num user_id;
    String name;
    String tel;
    String province;
    String city;
    String county;
    String area_code;
    String address_detail;
    num is_default;
    
    factory AddressItem.fromJson(Map<String,dynamic> json) => _$AddressItemFromJson(json);
    Map<String, dynamic> toJson() => _$AddressItemToJson(this);
}
