import 'package:json_annotation/json_annotation.dart';
import "addressItem.dart";
part 'addressList.g.dart';

@JsonSerializable()
class AddressList {
    AddressList();

    List<AddressItem> data;
    
    factory AddressList.fromJson(Map<String,dynamic> json) => _$AddressListFromJson(json);
    Map<String, dynamic> toJson() => _$AddressListToJson(this);
}
