import 'package:food_delivery_application/features/wishlist/data/model/wishlist_api_model.dart';

abstract class WishlistRepository {
  Future<List<WishlistApiModel>> getWishlistByUserId(String userId);
  Future<void> deleteWishlistItem(String wishlistItemId);
}
