import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery_application/core/error/failure.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/login_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs tokenSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, tokenSharedPrefs);
  });

//Test case: for correct email and password
  test(
      'should call the [AuthRepo.login] with correct email and password (santosh@gmail.com, santosh123)',
      () async {
    when(() => repository.loginCustomer(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'santosh@gmail.com' && password == 'santosh123') {
          return Future.value(const Right('token'));
        } else {
          return Future.value(
              const Left(ApiFailure(message: 'Invalid email or password')));
        }
      },
    );

    when(() => tokenSharedPrefs.saveToken(any())).thenAnswer(
      (_) async => Right(null),
    );

    final result = await usecase(LoginParams(
      email: 'santosh@gmail.com',
      password: 'santosh123',
    ));

    expect(result, const Right('token'));

    verify(() => repository.loginCustomer(any(), any())).called(1);
    verify(() => tokenSharedPrefs.saveToken(any())).called(1);

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });

// Test:Incorrect email/password
  test(
      'should return [ApiFailure] when login is attempted with incorrect email and/or password',
      () async {
    // Arrange
    when(() => repository.loginCustomer(any(), any())).thenAnswer(
      (invocation) async {
        final email = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        if (email == 'santosh@gmail.com' && password == 'santosh123') {
          return Future.value(const Right('token')); // Success case
        } else {
          return Future.value(
              const Left(ApiFailure(message: 'Invalid email or password')));
        }
      },
    );

    // Act
    final result = await usecase(LoginParams(
      email: 'wrong@gmail.com', // Incorrect email
      password: 'wrongpassword', // Incorrect password
    ));

    // Assert
    expect(
        result, const Left(ApiFailure(message: 'Invalid email or password')));

    verify(() => repository.loginCustomer('wrong@gmail.com', 'wrongpassword'))
        .called(1);
    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(
        tokenSharedPrefs); // Ensure token saving is never called
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });

// Test: Empty Email and Password
  test('should return [ApiFailure] when email or password is empty', () async {
    // Arrange
    when(() => repository.loginCustomer(any(), any())).thenAnswer(
      (_) async =>
          const Left(ApiFailure(message: 'Email and password cannot be empty')),
    );

    // Act
    final result = await usecase(LoginParams(
      email: '', // Empty email
      password: '', // Empty password
    ));

    // Assert
    expect(result,
        const Left(ApiFailure(message: 'Email and password cannot be empty')));

    verify(() => repository.loginCustomer('', '')).called(1);
    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  //  Test: Network Failure During Login
  test('should return [ApiFailure] when network failure occurs', () async {
    // Arrange
    when(() => repository.loginCustomer(any(), any())).thenAnswer(
      (_) async =>
          const Left(ApiFailure(message: 'Network failure, please try again')),
    );

    // Act
    final result = await usecase(LoginParams(
      email: 'santosh@gmail.com',
      password: 'santosh123',
    ));

    // Assert
    expect(result,
        const Left(ApiFailure(message: 'Network failure, please try again')));

    verify(() => repository.loginCustomer(any(), any())).called(1);
    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
