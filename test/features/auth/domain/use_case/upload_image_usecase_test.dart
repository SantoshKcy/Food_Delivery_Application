import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/auth/domain/repository/auth_repository.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

class TestFailure extends Failure {
  const TestFailure({required super.message});
}

void main() {
  late UploadImageUsecase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = UploadImageUsecase(mockRepository);
  });

  // Test case for successful image upload
  test(
      'should call uploadProfilePicture with correct File and return image URL',
      () async {
    // Arrange
    final file = File('path/to/image.jpg');
    const imageUrl = 'https://example.com/image.jpg';

    when(() => mockRepository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Right(imageUrl));

    // Act
    final result = await useCase(UploadImageParams(file: file));

    // Assert
    expect(result, const Right(imageUrl));
    verify(() => mockRepository.uploadProfilePicture(file)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return [ApiFailure] when uploadProfilePicture fails', () async {
    // Arrange
    final file = File('path/to/image.jpg');
    const failure = ApiFailure(message: 'Failed to upload image');

    when(() => mockRepository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(UploadImageParams(file: file));

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.uploadProfilePicture(file)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });
}
