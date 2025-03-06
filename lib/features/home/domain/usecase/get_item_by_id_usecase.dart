import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';
import 'package:food_delivery_application/features/home/domain/repository/home_repository.dart';

class GetItemByIdUseCase {
  final IHomeRepository homeRepository;

  GetItemByIdUseCase({required this.homeRepository});

  Future<Either<Failure, HomeEntity>> call(String id) async {
    log("📢 UseCase: Fetching item by ID ➝ $id");

    final result = await homeRepository.getItemById(id);

    log("✅ UseCase: Repository returned ${result.isRight() ? 'success' : 'failure'} for item ID ➝ $id");

    return result;
  }
}
