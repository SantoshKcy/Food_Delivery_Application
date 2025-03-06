import 'package:food_delivery_application/features/wishlist/data/data_source/wishlist_remote_data_source.dart';
import 'package:food_delivery_application/features/wishlist/data/model/wishlist_api_model.dart';

class WishlistRemoteRepository {
  final WishlistRemoteDataSource _wishlistRemoteDataSource;

  WishlistRemoteRepository(
      {required WishlistRemoteDataSource wishlistRemoteDataSource})
      : _wishlistRemoteDataSource = wishlistRemoteDataSource;

  Future<List<WishlistApiModel>> getWishlistByUserId(String userId) async {
    return await _wishlistRemoteDataSource.getWishlistByUserId(userId);
  }

  Future<void> deleteWishlistItem(String wishlistItemId) async {
    await _wishlistRemoteDataSource.deleteWishlistItem(wishlistItemId);
  }
}
