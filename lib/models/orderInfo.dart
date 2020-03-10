import 'package:json_annotation/json_annotation.dart';
import "midOrderItem.dart";
import "invoiceInfo.dart";
part 'orderInfo.g.dart';

@JsonSerializable()
class OrderInfo {
    OrderInfo();

    String order_sn;
    num user_id;
    String user_name;
    num order_state;
    String original_order_price;
    String after_using_coupon_price;
    String after_using_integral_price;
    String after_using_pay_price;
    String order_price;
    num give_integral;
    String pay_name;
    String pay_code;
    String bystages_val;
    String create_time;
    String upd_time;
    num invalid_pay_time;
    String logistics_name;
    String logistics_tel;
    String logistics_address;
    String logistics_code;
    String logistics_sn;
    String pay_time;
    String deliver_goods_time;
    String sign_goods_time;
    String invalid_sign_goods_time;
    String order_visible_note;
    String son_into_type;
    String order_state_name;
    String logistics_code_name;
    List<MidOrderItem> mid_order;
    InvoiceInfo invoice;
    
    factory OrderInfo.fromJson(Map<String,dynamic> json) => _$OrderInfoFromJson(json);
    Map<String, dynamic> toJson() => _$OrderInfoToJson(this);
}
