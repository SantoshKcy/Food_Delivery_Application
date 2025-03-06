import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';

abstract interface class IHomeRepository {
  Future<Either<Failure, List<HomeEntity>>> getItemsByTag(String tag);

  Future<Either<Failure, HomeEntity>> getItemById(String id);
}
