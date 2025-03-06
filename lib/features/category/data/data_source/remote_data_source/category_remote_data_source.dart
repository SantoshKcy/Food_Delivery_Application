import 'package:dio/dio.dart';
import 'package:food_delivery_application/app/constants/api_endpoints.dart';
import 'package:food_delivery_application/features/category/data/data_source/category_data_source.dart';
import 'package:food_delivery_application/features/category/data/dto/get_all_categories_dto.dart';
import 'package:food_delivery_application/features/category/data/model/category_api_model.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';


class CategoryRemoteDataSource implements ICategoryDataSource {
  final Dio _dio;

  CategoryRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CategoryEntity>> getCategories() async {
    try {
      // Send GET request to fetch categories
      var response = await _dio.get(ApiEndpoints.getAllCategories);

      if (response.statusCode == 200) {
        // Parse response with GetAllCategoriesDTO
        GetAllCategoriesDTO categoriesDTO = GetAllCategoriesDTO.fromJson(response.data);

        // Convert API models (CategoryApiModel) to domain entities (CategoryEntity)
        return CategoryApiModel.toEntityList(categoriesDTO.data);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
