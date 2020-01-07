// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchLogItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchLogItem _$SearchLogItemFromJson(Map<String, dynamic> json) {
  return SearchLogItem()
    ..user_id = json['user_id'] as num
    ..search_keyword = json['search_keyword'] as String;
}

Map<String, dynamic> _$SearchLogItemToJson(SearchLogItem instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'search_keyword': instance.search_keyword
    };
