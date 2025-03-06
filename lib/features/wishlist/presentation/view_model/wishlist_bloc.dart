import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:food_delivery_application/features/wishlist/domain/usecase/delete_wishlist_item.dart';
import 'package:food_delivery_application/features/wishlist/domain/usecase/get_wishlist_by_user_id.dart';

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

// BLoC
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlistByUserId _getWishlistByUserId;
  final DeleteWishlistItem _deleteWishlistItem;

  WishlistBloc({
    required GetWishlistByUserId getWishlistByUserId,
    required DeleteWishlistItem deleteWishlistItem,
  })  : _getWishlistByUserId = getWishlistByUserId,
        _deleteWishlistItem = deleteWishlistItem,
        super(WishlistInitial());

  @override
  Stream<WishlistState> mapEventToState(WishlistEvent event) async* {
    if (event is GetWishlistEvent) {
      yield WishlistLoading();
      try {
        final wishlistItems = await _getWishlistByUserId.execute(event.userId);
        yield WishlistLoaded(wishlistItems: wishlistItems);
      } catch (e) {
        yield WishlistError(message: e.toString());
      }
    } else if (event is DeleteWishlistItemEvent) {
      yield WishlistLoading();
      try {
        await _deleteWishlistItem.execute(event.wishlistItemId);
        // You may want to fetch updated wishlist after deleting an item
        yield WishlistLoaded(
            wishlistItems: []); // Reload wishlist or modify state accordingly
      } catch (e) {
        yield WishlistError(message: e.toString());
      }
    }
  }
}
