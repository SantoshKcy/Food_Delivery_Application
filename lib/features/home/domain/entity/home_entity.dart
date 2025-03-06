import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';


class HomeEntity extends Equatable {
  final String? id;
  final String name;
  final String description;
  final String price;
  final String availability;
  final String image;
  final CategoryEntity category;

  final List<String> tags;
  final DateTime? createdAt;

  const HomeEntity({
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
