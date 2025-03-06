import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';

abstract interface class ICategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
