// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_categories_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllCategoriesDTO _$GetAllCategoriesDTOFromJson(Map<String, dynamic> json) =>
    GetAllCategoriesDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => CategoryApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllCategoriesDTOToJson(
        GetAllCategoriesDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
