import 'package:food_delivery_application/features/wishlist/domain/entity/wishlist_entity.dart';

abstract class WishlistDataSource {
  /// Fetches wishlist items by user ID
  Future<List<WishlistEntity>> getWishlistItemsByUserId(String userId);

  /// Deletes an item from the wishlist by item ID
  Future<void> deleteWishlistItem(String wishlistItemId);
}
