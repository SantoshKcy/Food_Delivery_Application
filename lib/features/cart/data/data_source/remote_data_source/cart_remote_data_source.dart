import 'package:dio/dio.dart';
import 'package:food_delivery_application/app/constants/api_endpoints.dart';
import 'package:food_delivery_application/features/cart/data/data_source/cart_data_source.dart';
import 'package:food_delivery_application/features/cart/data/model/cart_api_model.dart';
import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';

class CartRemoteDataSource implements CartDataSource {
  final Dio _dio;

  CartRemoteDataSource({required Dio dio}) : _dio = dio;

  @override
  Future<List<CartEntity>> getCartItemsByUserId(String userId) async {
    try {
      final apiUrl = "${ApiEndpoints.getCartItemsByUserId}/$userId";
      var response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        if (response.data == null || response.data["cartItems"] == null) {
          throw Exception("Invalid API response: Missing 'cartItems' field");
        }

        // Assuming the API returns a list of cart items in "cartItems" field
        var cartItemsData = response.data["cartItems"];
        return CartApiModel.toEntityList(
          cartItemsData.map((json) => CartApiModel.fromJson(json)).toList(),
        );
      } else {
        throw Exception(
            "Failed to fetch cart items: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<void> deleteCartItem(String cartItemId) async {
    try {
      final apiUrl = "${ApiEndpoints.deleteCartItem}/$cartItemId";
      var response = await _dio.delete(apiUrl);

      if (response.statusCode == 200) {
        // Successfully deleted, return nothing
        return;
      } else {
        throw Exception(
            "Failed to delete cart item: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.statusCode} - ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
