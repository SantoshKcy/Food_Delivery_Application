import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';

abstract interface class IHomeDataSource {
  /// ✅ Fetch items by tag from the remote source
  Future<List<HomeEntity>> getItemsByTag(String tag);

  /// ✅ Fetch a single item by its ID from the remote source
  Future<HomeEntity> getItemById(String id);
}
