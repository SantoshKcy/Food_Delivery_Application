import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failures.dart';
import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartEntity>>> getCartItemsByUserId(String userId);
  Future<Either<Failure, bool>> deleteCartItem(String cartId);
}
