import 'package:food_delivery_application/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:food_delivery_application/features/wishlist/domain/repository/wishlist_repository.dart';

class GetWishlistByUserId {
  final WishlistRepository _repository;

  GetWishlistByUserId(this._repository);

  Future<List<WishlistApiModel>> execute(String userId) async {
    return await _repository.getWishlistByUserId(userId);
  }
}
