// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_cart_items_by_user_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCartItemsByUserIdDTO _$GetCartItemsByUserIdDTOFromJson(
        Map<String, dynamic> json) =>
    GetCartItemsByUserIdDTO(
      cartItems: (json['cartItems'] as List<dynamic>)
          .map((e) => CartApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetCartItemsByUserIdDTOToJson(
        GetCartItemsByUserIdDTO instance) =>
    <String, dynamic>{
      'cartItems': instance.cartItems,
    };
