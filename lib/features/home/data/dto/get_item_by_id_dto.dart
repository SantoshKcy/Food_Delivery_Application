import 'package:food_delivery_application/features/home/data/model/home_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_item_by_id_dto.g.dart';

@JsonSerializable()
class GetItemByIdDTO {
  final bool success;

  @JsonKey(fromJson: _countFromJson, toJson: _countToJson)
  @JsonKey(name: "data", defaultValue: [])
  final HomeApiModel item;

  GetItemByIdDTO({
    required this.success,
    required this.item,
  });

  static int _countFromJson(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }

  static dynamic _countToJson(int value) => value;

  factory GetItemByIdDTO.fromJson(Map<String, dynamic> json) {
    if (json['data'] is! Map) {
      throw Exception("Invalid API format: 'data' is not a Map");
    }
    return _$GetItemByIdDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetItemByIdDTOToJson(this);
}
