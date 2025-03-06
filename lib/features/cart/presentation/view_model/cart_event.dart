import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class LoadCartItems extends CartEvent {
  final String userId;

  const LoadCartItems(this.userId);

  @override
  List<Object?> get props => [userId];
}

class RemoveCartItem extends CartEvent {
  final String cartId;

  const RemoveCartItem(this.cartId);

  @override
  List<Object?> get props => [cartId];
}
