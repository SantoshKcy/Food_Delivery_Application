import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';

abstract class CartDataSource {
  /// Fetches cart items by user ID
  Future<List<CartEntity>> getCartItemsByUserId(String userId);

  /// Deletes an item from the cart by item ID
  Future<void> deleteCartItem(String cartItemId);
}
