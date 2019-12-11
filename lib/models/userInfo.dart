import 'package:json_annotation/json_annotation.dart';

part 'userInfo.g.dart';

@JsonSerializable()
class UserInfo {
    UserInfo();

    num user_id;
    String user_token;
    String user_name;
    String user_img;
    String add_time;
    String name;
    String email;
    String phone;
    num integral;
    
    factory UserInfo.fromJson(Map<String,dynamic> json) => _$UserInfoFromJson(json);
    Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
