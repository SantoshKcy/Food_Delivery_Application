import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failures.dart';
import 'package:food_delivery_application/core/usecase/usecase.dart';
import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';
import 'package:food_delivery_application/features/cart/domain/repository/cart_repository.dart';

class GetCartItemsByUserIdUseCase implements UseCase<List<CartEntity>, String> {
  final CartRepository cartRepository;

  GetCartItemsByUserIdUseCase({required this.cartRepository});

  @override
  Future<Either<Failure, List<CartEntity>>> call(String userId) {
    return cartRepository.getCartItemsByUserId(userId);
  }
}

class DeleteCartItemUseCase implements UseCase<bool, String> {
  final CartRepository cartRepository;

  DeleteCartItemUseCase({required this.cartRepository});

  @override
  Future<Either<Failure, bool>> call(String cartId) {
    return cartRepository.deleteCartItem(cartId);
  }
}
