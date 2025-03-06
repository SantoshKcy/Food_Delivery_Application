import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_delivery_application/features/cart/domain/usecase/delete_cart_item_usecase.dart';
import 'package:food_delivery_application/features/cart/domain/usecase/get_cart_items_by_userid_usecase.dart';
import 'package:food_delivery_application/features/cart/presentation/view/cart_event.dart';
import 'package:food_delivery_application/features/cart/presentation/view/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartItemsByUserIdUseCase getCartItemsByUserIdUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;

  CartBloc({
    required this.getCartItemsByUserIdUseCase,
    required this.deleteCartItemUseCase,
  }) : super(CartState.initial());

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is LoadCartItems) {
      yield* _mapLoadCartItemsToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemToState(event);
    }
  }

  Stream<CartState> _mapLoadCartItemsToState(LoadCartItems event) async* {
    yield state.copyWith(isLoading: true);

    final result = await getCartItemsByUserIdUseCase(event.userId);

    yield result.fold(
      (failure) =>
          state.copyWith(isLoading: false, errorMessage: failure.message),
      (cartItems) => state.copyWith(isLoading: false, cartItems: cartItems),
    );
  }

  Stream<CartState> _mapRemoveCartItemToState(RemoveCartItem event) async* {
    final result = await deleteCartItemUseCase(event.cartId);

    yield result.fold(
      (failure) => state.copyWith(errorMessage: failure.message),
      (success) {
        final updatedCartItems = List<CartEntity>.from(state.cartItems)
          ..removeWhere((item) => item.id == event.cartId);
        return state.copyWith(cartItems: updatedCartItems);
      },
    );
  }
}
