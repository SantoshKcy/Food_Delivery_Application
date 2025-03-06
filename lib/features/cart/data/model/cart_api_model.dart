import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/cart/data/model/item_api_model.dart';
import 'package:food_delivery_application/features/cart/domain/entity/cart_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_api_model.g.dart';

@JsonSerializable()
class CartApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String customerId;
  final ItemApiModel item;
  final int quantity;
  final double price;
  final DateTime createdAt;

  const CartApiModel({
    this.id,
    required this.customerId,
    required this.item,
    required this.quantity,
    required this.price,
    required this.createdAt,
  });

  /// ✅ **1. Convert API JSON to `CartApiModel`**
  factory CartApiModel.fromJson(Map<String, dynamic> json) =>
      _$CartApiModelFromJson(json);

  /// ✅ **2. Convert `CartApiModel` to JSON**
  Map<String, dynamic> toJson() => _$CartApiModelToJson(this);

  /// ✅ **3. Convert API Model to Domain Entity (`CartEntity`)**
  CartEntity toEntity() => CartEntity(
        id: id,
        customerId: customerId,
        item: item.toEntity(), // ✅ Convert item API model to entity
        quantity: quantity,
        price: price,
        createdAt: createdAt,
      );

  /// ✅ **4. Create API Model from Domain Entity (`CartEntity`)**
  factory CartApiModel.fromEntity(CartEntity entity) => CartApiModel(
        id: entity.id,
        customerId: entity.customerId,
        item: ItemApiModel.fromEntity(
            entity.item), // Convert Item entity to API model
        quantity: entity.quantity,
        price: entity.price,
        createdAt: entity.createdAt,
      );

  /// ✅ **5. Convert List of API Models to List of Entities**
  static List<CartEntity> toEntityList(List<CartApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        id,
        customerId,
        item,
        quantity,
        price,
        createdAt,
      ];
}
