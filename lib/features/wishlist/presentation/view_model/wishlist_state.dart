import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/wishlist/domain/entity/wishlist_entity.dart';

// States
abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<WishlistEntity> wishlistItems;

  const WishlistLoaded({required this.wishlistItems});

  @override
  List<Object?> get props => [wishlistItems];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError({required this.message});

  @override
  List<Object?> get props => [message];
}
