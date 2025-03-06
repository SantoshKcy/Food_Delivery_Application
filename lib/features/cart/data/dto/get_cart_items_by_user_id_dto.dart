import 'package:food_delivery_application/features/cart/data/model/cart_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_cart_items_by_user_id_dto.g.dart';

@JsonSerializable()
class GetCartItemsByUserIdDTO {
  final List<CartApiModel> cartItems;

  GetCartItemsByUserIdDTO({required this.cartItems});

  /// Converts JSON to GetCartItemsByUserIdDTO
  factory GetCartItemsByUserIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetCartItemsByUserIdDTOFromJson(json);

  /// Converts GetCartItemsByUserIdDTO to JSON
  Map<String, dynamic> toJson() => _$GetCartItemsByUserIdDTOToJson(this);
}
