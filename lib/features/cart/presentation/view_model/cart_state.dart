import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';

class CartState extends Equatable {
  final bool isLoading;
  final List<CartEntity> cartItems;
  final String? errorMessage;

  const CartState({
    required this.isLoading,
    required this.cartItems,
    this.errorMessage,
  });

  factory CartState.initial() {
    return const CartState(
      isLoading: false,
      cartItems: [],
      errorMessage: null,
    );
  }

  CartState copyWith({
    bool? isLoading,
    List<CartEntity>? cartItems,
    String? errorMessage,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, cartItems, errorMessage ?? ''];
}
