import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/home/data/data_source/home_data_source.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';
import 'package:food_delivery_application/features/home/domain/repository/home_repository.dart';

class HomeRemoteRepository implements IHomeRepository {
  final IHomeDataSource remoteDataSource;

  HomeRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<HomeEntity>>> getItemsByTag(String tag) async {
    try {
      final items = await remoteDataSource.getItemsByTag(tag);
      return Right(items);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, HomeEntity>> getItemById(String id) async {
    try {
      final item = await remoteDataSource
          .getItemById(id); // Fetching a single item by ID
      return Right(item);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
