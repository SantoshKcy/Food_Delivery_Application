import 'package:food_delivery_application/features/wishlist/domain/entity/wishlist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wishlist_api_model.g.dart';

@JsonSerializable()
class WishlistApiModel {
  final String? id;
  final String userId;
  final String itemId;
  final DateTime createdAt;

  WishlistApiModel({
    this.id,
    required this.userId,
    required this.itemId,
    required this.createdAt,
  });

  factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);

  WishlistEntity toEntity() => WishlistEntity(
        id: id,
        userId: userId,
        itemId: itemId,
        createdAt: createdAt,
      );
}
