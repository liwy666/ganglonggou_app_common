import 'package:json_annotation/json_annotation.dart';

part 'couponItem.g.dart';

@JsonSerializable()
class CouponItem {
    CouponItem();

    num coupon_id;
    String coupon_name;
    String coupon_desc;
    String start_grant_time;
    String end_grant_time;
    String start_use_time;
    String end_use_time;
    List classify;
    List solo;
    String found_sum;
    String cut_sum;
    num coupon_number;
    num coupon_remainder_number;
    String grant_type;
    
    factory CouponItem.fromJson(Map<String,dynamic> json) => _$CouponItemFromJson(json);
    Map<String, dynamic> toJson() => _$CouponItemToJson(this);
}
