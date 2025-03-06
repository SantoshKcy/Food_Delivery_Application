import 'package:dio/dio.dart';
import 'package:food_delivery_application/app/constants/api_endpoints.dart';
import 'package:food_delivery_application/features/home/data/data_source/home_data_source.dart';
import 'package:food_delivery_application/features/home/data/dto/get_items_by_tag_dto.dart';
import 'package:food_delivery_application/features/home/data/model/home_api_model.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';

class HomeRemoteDataSource implements IHomeDataSource {
  final Dio _dio;

  HomeRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<HomeEntity>> getItemsByTag(String tag) async {
    try {
      final apiUrl = "${ApiEndpoints.getItemsByTag}/$tag";
      var response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        if (response.data == null || response.data["items"] == null) {
          throw Exception("Invalid API response: Missing 'items' field");
        }

        GetItemsByTagDTO itemsDTO = GetItemsByTagDTO.fromJson(response.data);
        return HomeApiModel.toEntityList(itemsDTO.items);
      } else {
        throw Exception("Failed to fetch items: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<HomeEntity> getItemById(String id) async {
    try {
      final apiUrl = "${ApiEndpoints.getItemById}/$id";
      var response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        if (response.data == null || response.data["item"] == null) {
          throw Exception("Invalid API response: Missing 'item' field");
        }

        var itemData = response.data["item"];
        return HomeApiModel.toEntity(itemData);
      } else {
        throw Exception("Failed to fetch item: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
