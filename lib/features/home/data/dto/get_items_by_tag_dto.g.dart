// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_items_by_tag_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetItemsByTagDTO _$GetItemsByTagDTOFromJson(Map<String, dynamic> json) =>
    GetItemsByTagDTO(
      success: json['success'] as bool,
      count: GetItemsByTagDTO._countFromJson(json['count']),
      items: (json['data'] as List<dynamic>?)
              ?.map((e) => HomeApiModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$GetItemsByTagDTOToJson(GetItemsByTagDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': GetItemsByTagDTO._countToJson(instance.count),
      'data': instance.items,
    };
