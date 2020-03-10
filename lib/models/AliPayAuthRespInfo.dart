import 'package:json_annotation/json_annotation.dart';

part 'AliPayAuthRespInfo.g.dart';

@JsonSerializable()
class AliPayAuthRespInfo {
    AliPayAuthRespInfo();

    String success;
    String result_code;
    String app_id;
    String auth_code;
    String scope;
    String alipay_open_id;
    String user_id;
    String target_id;
    
    factory AliPayAuthRespInfo.fromJson(Map<String,dynamic> json) => _$AliPayAuthRespInfoFromJson(json);
    Map<String, dynamic> toJson() => _$AliPayAuthRespInfoToJson(this);
}
