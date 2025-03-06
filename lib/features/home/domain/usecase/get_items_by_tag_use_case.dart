import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/home/domain/entity/home_entity.dart';
import 'package:food_delivery_application/features/home/domain/repository/home_repository.dart';

class GetItemsByTagUseCase {
  final IHomeRepository homeRepository;

  GetItemsByTagUseCase({required this.homeRepository});

  Future<Either<Failure, List<HomeEntity>>> call(String tag) async {
    log("📢 UseCase: Fetching items with tag ➝ $tag");
    
    final result = await homeRepository.getItemsByTag(tag);
    
    log("✅ UseCase: Repository returned ${result.isRight() ? 'success' : 'failure'} for tag ➝ $tag");

    return result;
  }
}
