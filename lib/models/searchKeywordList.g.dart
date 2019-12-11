// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchKeywordList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchKeywordList _$SearchKeywordListFromJson(Map<String, dynamic> json) {
  return SearchKeywordList()
    ..data = (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : SearchKeywordItem.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$SearchKeywordListToJson(SearchKeywordList instance) =>
    <String, dynamic>{'data': instance.data};
