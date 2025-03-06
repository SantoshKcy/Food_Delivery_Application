

import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryDataSource {
  Future<List<CategoryEntity>> getCategories();
}
