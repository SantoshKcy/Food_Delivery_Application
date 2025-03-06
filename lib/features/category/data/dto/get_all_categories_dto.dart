import 'package:food_delivery_application/features/category/data/model/category_api_model.dart';
import 'package:json_annotation/json_annotation.dart';


part 'get_all_categories_dto.g.dart';

@JsonSerializable()
class GetAllCategoriesDTO {
  final bool success;
  final int count;
  final List<CategoryApiModel> data;

  GetAllCategoriesDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllCategoriesDTOToJson(this);

  factory GetAllCategoriesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllCategoriesDTOFromJson(json);
}
