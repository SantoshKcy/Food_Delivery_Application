import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/app/usecase/usecase.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';
import 'package:food_delivery_application/features/category/domain/repository/category_repository.dart';


class GetAllCategoriesUseCase implements UseCaseWithoutParams<List<CategoryEntity>> {
  final ICategoryRepository categoryRepository;

  GetAllCategoriesUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, List<CategoryEntity>>> call() {
    log("📢 UseCase: Calling repository to get all items");
    return categoryRepository.getCategories();
  }
}
