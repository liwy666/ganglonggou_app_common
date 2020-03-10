// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo()
    ..user_id = json['user_id'] as num
    ..user_token = json['user_token'] as String
    ..user_name = json['user_name'] as String
    ..user_img = json['user_img'] as String
    ..add_time = json['add_time'] as String
    ..name = json['name'] as String
    ..email = json['email'] as String
    ..phone = json['phone'] as String
    ..integral = json['integral'] as num;
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'user_token': instance.user_token,
      'user_name': instance.user_name,
      'user_img': instance.user_img,
      'add_time': instance.add_time,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'integral': instance.integral
    };
