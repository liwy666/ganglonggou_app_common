// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weChatPrepayInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeChatPrepayInfo _$WeChatPrepayInfoFromJson(Map<String, dynamic> json) {
  return WeChatPrepayInfo()
    ..mch_id = json['mch_id'] as String
    ..nonce_str = json['nonce_str'] as String
    ..prepay_id = json['prepay_id'] as String
    ..result_code = json['result_code'] as String
    ..return_code = json['return_code'] as String
    ..sign = json['sign'] as String
    ..timestamp = json['timestamp'] as String;
}

Map<String, dynamic> _$WeChatPrepayInfoToJson(WeChatPrepayInfo instance) =>
    <String, dynamic>{
      'mch_id': instance.mch_id,
      'nonce_str': instance.nonce_str,
      'prepay_id': instance.prepay_id,
      'result_code': instance.result_code,
      'return_code': instance.return_code,
      'sign': instance.sign,
      'timestamp': instance.timestamp
    };
