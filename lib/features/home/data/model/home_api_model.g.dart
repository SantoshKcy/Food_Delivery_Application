// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeApiModel _$HomeApiModelFromJson(Map<String, dynamic> json) => HomeApiModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String,
      price: HomeApiModel._priceFromJson(json['price']),
      availability: json['availability'] as String,
      image: json['image'] as String,
      category:
          CategoryApiModel.fromJson(json['category'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$HomeApiModelToJson(HomeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': HomeApiModel._priceToJson(instance.price),
      'availability': instance.availability,
      'image': instance.image,
      'category': instance.category,
      'tags': instance.tags,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
