import 'package:food_delivery_application/features/wishlist/domain/repository/wishlist_repository.dart';

class DeleteWishlistItem {
  final WishlistRepository _repository;

  DeleteWishlistItem(this._repository);

  Future<void> execute(String wishlistItemId) async {
    return await _repository.deleteWishlistItem(wishlistItemId);
  }
}
