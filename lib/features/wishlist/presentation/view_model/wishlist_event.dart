import 'package:equatable/equatable.dart';

// Events
abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class GetWishlistEvent extends WishlistEvent {
  final String userId;

  const GetWishlistEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteWishlistItemEvent extends WishlistEvent {
  final String wishlistItemId;

  const DeleteWishlistItemEvent(this.wishlistItemId);

  @override
  List<Object> get props => [wishlistItemId];
}
