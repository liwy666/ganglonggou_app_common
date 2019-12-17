// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getVersionInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVersionInfo _$GetVersionInfoFromJson(Map<String, dynamic> json) {
  return GetVersionInfo()
    ..id = json['id'] as num
    ..platform = json['platform'] as String
    ..add_time = json['add_time'] as String
    ..app_version = json['app_version'] as String
    ..build_number = json['build_number'] as num
    ..file_size = json['file_size'] as String
    ..download_url = json['download_url'] as String
    ..describe = json['describe'] as String
    ..result_code = json['result_code'] as String;
}

Map<String, dynamic> _$GetVersionInfoToJson(GetVersionInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'add_time': instance.add_time,
      'app_version': instance.app_version,
      'build_number': instance.build_number,
      'file_size': instance.file_size,
      'download_url': instance.download_url,
      'describe': instance.describe,
      'result_code': instance.result_code
    };
