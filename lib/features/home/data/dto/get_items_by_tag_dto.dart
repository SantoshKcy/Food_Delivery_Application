import 'package:food_delivery_application/features/home/data/model/home_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_items_by_tag_dto.g.dart';
@JsonSerializable()
class GetItemsByTagDTO {
  final bool success;

  @JsonKey(fromJson: _countFromJson, toJson: _countToJson)
  final int count;

  @JsonKey(name: "data", defaultValue: []) // ✅ Ensures `data` is always a list
  final List<HomeApiModel> items;

  GetItemsByTagDTO({
    required this.success,
    required this.count,
    required this.items,
  });

  /// ✅ Ensure `count` is always an `int`
  static int _countFromJson(dynamic value) {
    if (value is int) return value; // ✅ If already an int, return as is
    return int.tryParse(value.toString()) ?? 0; // ✅ Convert from string to int
  }

  static dynamic _countToJson(int value) => value;

  factory GetItemsByTagDTO.fromJson(Map<String, dynamic> json) {
    if (json['data'] is! List) {
      throw Exception("Invalid API format: 'data' is not a List");
    }
    return _$GetItemsByTagDTOFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetItemsByTagDTOToJson(this);
}
