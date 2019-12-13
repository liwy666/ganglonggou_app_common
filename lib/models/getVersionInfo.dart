import 'package:json_annotation/json_annotation.dart';

part 'getVersionInfo.g.dart';

@JsonSerializable()
class GetVersionInfo {
    GetVersionInfo();

    num id;
    String platform;
    String add_time;
    String app_version;
    String download_url;
    String describe;
    String file_size;
    String result_code;
    
    factory GetVersionInfo.fromJson(Map<String,dynamic> json) => _$GetVersionInfoFromJson(json);
    Map<String, dynamic> toJson() => _$GetVersionInfoToJson(this);
}
