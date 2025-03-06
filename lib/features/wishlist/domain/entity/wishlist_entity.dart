import 'package:equatable/equatable.dart';

class WishlistEntity extends Equatable {
  final String? id;
  final String userId;
  final String itemId;
  final DateTime createdAt;

  const WishlistEntity({
    this.id,
    required this.userId,
    required this.itemId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, userId, itemId, createdAt];
}
