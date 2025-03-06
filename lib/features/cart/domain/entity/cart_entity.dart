import 'package:equatable/equatable.dart';
import 'package:food_delivery_application/features/home/domain/entity/item_entity.dart';

class CartEntity extends Equatable {
  final String? id;
  final String customerId;
  final ItemEntity item;
  final int quantity;
  final double price;
  final DateTime createdAt;

  const CartEntity({
    this.id,
    required this.customerId,
    required this.item,
    required this.quantity,
    required this.price,
    required this.createdAt,
  });

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
