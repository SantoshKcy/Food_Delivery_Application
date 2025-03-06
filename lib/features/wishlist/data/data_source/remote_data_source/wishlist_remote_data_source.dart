import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:food_delivery_application/app/constants/api_endpoints.dart';
import 'package:food_delivery_application/features/wishlist/data/dto/get_wishlist_items_by_user_id_dto.dart';
import 'package:food_delivery_application/features/wishlist/data/model/wishlist_api_model.dart';

class WishlistRemoteDataSource {
  final Dio _dio;

  WishlistRemoteDataSource({required Dio dio}) : _dio = dio;

  Future<List<WishlistApiModel>> getWishlistByUserId(String userId) async {
    try {
      final apiUrl = "${ApiEndpoints.getWishlistByUserId}/$userId";
      var response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        if (response.data == null || response.data["wishlistItems"] == null) {
          throw Exception(
              "Invalid API response: Missing 'wishlistItems' field");
        }

        GetWishlistItemsByUserIdDTO wishlistDTO =
            GetWishlistItemsByUserIdDTO.fromJson(response.data);
        return wishlistDTO.wishlistItems;
      } else {
        throw Exception("Failed to fetch wishlist: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> deleteWishlistItem(String wishlistItemId) async {
    try {
      final apiUrl = "${ApiEndpoints.deleteWishlistItem}/$wishlistItemId";
      var response = await _dio.delete(apiUrl);

      if (response.statusCode != 200) {
        throw Exception(
            "Failed to delete wishlist item: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
