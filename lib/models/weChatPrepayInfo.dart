import 'package:json_annotation/json_annotation.dart';

part 'weChatPrepayInfo.g.dart';

@JsonSerializable()
class WeChatPrepayInfo {
    WeChatPrepayInfo();

    String mch_id;
    String nonce_str;
    String prepay_id;
    String result_code;
    String return_code;
    String sign;
    String timestamp;
    
    factory WeChatPrepayInfo.fromJson(Map<String,dynamic> json) => _$WeChatPrepayInfoFromJson(json);
    Map<String, dynamic> toJson() => _$WeChatPrepayInfoToJson(this);
}
