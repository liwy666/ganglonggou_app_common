import 'package:json_annotation/json_annotation.dart';

part 'goodsCouponItem.g.dart';

@JsonSerializable()
class GoodsCouponItem {
    GoodsCouponItem();

    num coupon_id;
    String coupon_name;
    String coupon_desc;
    String start_grant_time;
    String end_grant_time;
    String start_use_time;
    String end_use_time;
    String found_sum;
    String cut_sum;
    num coupon_number;
    num coupon_remainder_number;
    String grant_type;
    String into_type;
    num is_del;
    
    factory GoodsCouponItem.fromJson(Map<String,dynamic> json) => _$GoodsCouponItemFromJson(json);
    Map<String, dynamic> toJson() => _$GoodsCouponItemToJson(this);
}
