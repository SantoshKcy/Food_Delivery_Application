import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/auth/domain/entity/auth_entity.dart';
import 'package:food_delivery_application/features/auth/domain/repository/auth_repository.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

// Mock the IAuthRepoitory
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUseCase useCase;
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    useCase = RegisterUseCase(mockRepository);

    registerFallbackValue(const AuthEntity(
      fName: '',
      lName: '',
      phone: '',
      email: '',
      password: '',
      image: '',
    ));
  });

  // Test case for successful signup
  test('should call registerCustomer with correct AuthEntity and return void',
      () async {
    // Arrange
    const params = RegisterUserParams(
      fname: 'Santosh',
      lname: 'KC',
      phone: '9840922949',
      email: 'santosh@gmail.com',
      password: 'santosh123',
      image: 'profile.jpg',
    );

    const authEntity = AuthEntity(
      fName: 'Santosh',
      lName: 'KC',
      phone: '9840922949',
      email: 'santosh@gmail.com',
      password: 'santosh123',
      image: 'profile.jpg',
    );

    // Mock the repository to return Right(null) for successful signup
    when(() => mockRepository.registerCustomer(authEntity))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.registerCustomer(authEntity)).called(1); //
    verifyNoMoreInteractions(mockRepository);
  });

  // Test case for signup failure
  test('should return a Failure when registerCustomer fails', () async {
    // Arrange
    const params = RegisterUserParams(
      fname: 'Santosh',
      lname: 'KC',
      phone: '9840922949',
      email: 'santosh@gmail.com',
      password: 'santosh123',
      image: 'profile.jpg',
    );

    const authEntity = AuthEntity(
      fName: 'Santosh',
      lName: 'KC',
      phone: '9840922949',
      email: 'santosh@gmail.com',
      password: 'santosh123',
      image: 'profile.jpg',
    );

    const failure = ApiFailure(message: 'Signup failed');

    // Mock the repository to return Left(Failure) for failed signup
    when(() => mockRepository.registerCustomer(authEntity))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.registerCustomer(authEntity)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  test('should return a Failure when email format is invalid', () async {
    // Arrange
    const params = RegisterUserParams(
      fname: 'Santosh',
      lname: 'KC',
      phone: '9840922949',
      email: 'invalid-email', // Invalid email format
      password: 'santosh123',
      image: 'profile.jpg',
    );

    const failure = ApiFailure(message: 'Invalid email format');

    when(() => mockRepository.registerCustomer(any()))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.registerCustomer(any())).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return a Failure when email is already in use', () async {
    // Arrange
    const params = RegisterUserParams(
      fname: 'Santosh',
      lname: 'KC',
      phone: '9840922949',
      email: 'santosh@gmail.com', // Email already registered
      password: 'santosh123',
      image: 'profile.jpg',
    );

    // const authEntity = AuthEntity(
    //   fName: 'Santosh',
    //   lName: 'KC',
    //   phone: '9840922949',
    //   email: 'santosh@gmail.com',
    //   password: 'santosh123',
    //   image: 'profile.jpg',
    // );

    const failure = ApiFailure(message: 'Email is already in use');

    // Mock the repository to return failure for this specific input
    when(() => mockRepository.registerCustomer(any(that: isA<AuthEntity>())))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.registerCustomer(any(
        that: isA<AuthEntity>()
            .having((e) => e.email, 'email', 'santosh@gmail.com')))).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });

  test('should return a Failure when email format is invalid', () async {
    // Arrange
    const params = RegisterUserParams(
      fname: 'Santosh',
      lname: 'KC',
      phone: '9840922949',
      email: 'invalid-email',
      password: 'santosh123',
      image: 'profile.jpg',
    );

    const failure = ApiFailure(message: 'Invalid email format');

    when(() => mockRepository.registerCustomer(any(that: isA<AuthEntity>())))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await useCase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => mockRepository.registerCustomer(any(
        that: isA<AuthEntity>()
            .having((e) => e.email, 'email', 'invalid-email')))).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  tearDown(() {
    reset(mockRepository);
  });
}
