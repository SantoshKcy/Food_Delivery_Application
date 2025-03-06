import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String? id;
  final String name;
  final String description;
  final String image;
  final DateTime? createdAt;

  const CategoryEntity({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, description, image, createdAt];
}
