import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:food_delivery_application/features/category/data/model/category_api_model.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';

part 'home_api_model.g.dart';

@JsonSerializable()
class HomeApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String description;

  /// ✅ Ensure `price` is always treated as a String
  @JsonKey(fromJson: _priceFromJson, toJson: _priceToJson)
  final String price;
  

  final String availability;
  final String image;
  final CategoryApiModel category;
  final List<String> tags;
  final DateTime? createdAt;

  const HomeApiModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.availability,
    required this.image,
    required this.category,
    required this.tags,
    this.createdAt,
  });

  /// ✅ **1. Convert API JSON to `HomeApiModel`**
  factory HomeApiModel.fromJson(Map<String, dynamic> json) =>
      _$HomeApiModelFromJson(json);

  /// ✅ **2. Convert `HomeApiModel` to JSON**
  Map<String, dynamic> toJson() => _$HomeApiModelToJson(this);

  /// ✅ **3. Convert API Model to Domain Entity (`HomeEntity`)**
  HomeEntity toEntity() => HomeEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        availability: availability,
        image: image,
        category: category.toEntity(), // ✅ Convert category API model to entity
        tags: tags,
        createdAt: createdAt,
      );

  /// ✅ **4. Create API Model from Domain Entity (`HomeEntity`)**
  factory HomeApiModel.fromEntity(HomeEntity entity) => HomeApiModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        price: entity.price,
        availability: entity.availability,
        image: entity.image,
        category: CategoryApiModel.fromEntity(entity.category),
        tags: entity.tags,
        createdAt: entity.createdAt,
      );

  /// ✅ **5. Convert List of API Models to List of Entities**
  static List<HomeEntity> toEntityList(List<HomeApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  /// ✅ **Fix `price` Type Issue**
  static String _priceFromJson(dynamic value) => value.toString();
  static dynamic _priceToJson(String value) => value;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        availability,
        image,
        category,
        tags,
        createdAt,
      ];
}
