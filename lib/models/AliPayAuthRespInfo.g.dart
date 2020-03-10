// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AliPayAuthRespInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AliPayAuthRespInfo _$AliPayAuthRespInfoFromJson(Map<String, dynamic> json) {
  return AliPayAuthRespInfo()
    ..success = json['success'] as String
    ..result_code = json['result_code'] as String
    ..app_id = json['app_id'] as String
    ..auth_code = json['auth_code'] as String
    ..scope = json['scope'] as String
    ..alipay_open_id = json['alipay_open_id'] as String
    ..user_id = json['user_id'] as String
    ..target_id = json['target_id'] as String;
}

Map<String, dynamic> _$AliPayAuthRespInfoToJson(AliPayAuthRespInfo instance) =>
    <String, dynamic>{
      'success': instance.success,
      'result_code': instance.result_code,
      'app_id': instance.app_id,
      'auth_code': instance.auth_code,
      'scope': instance.scope,
      'alipay_open_id': instance.alipay_open_id,
      'user_id': instance.user_id,
      'target_id': instance.target_id
    };
