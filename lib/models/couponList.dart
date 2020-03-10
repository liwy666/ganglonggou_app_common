import 'package:json_annotation/json_annotation.dart';
import "couponItem.dart";
part 'couponList.g.dart';

@JsonSerializable()
class CouponList {
    CouponList();

    List<CouponItem> data;
    
    factory CouponList.fromJson(Map<String,dynamic> json) => _$CouponListFromJson(json);
    Map<String, dynamic> toJson() => _$CouponListToJson(this);
}
