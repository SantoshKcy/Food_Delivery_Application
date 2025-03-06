import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/category/data/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';
import 'package:food_delivery_application/features/category/domain/repository/category_repository.dart';


class CategoryRemoteRepository implements ICategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
