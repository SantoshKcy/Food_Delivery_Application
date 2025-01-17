import 'package:food_delivery_application/core/network/hive_service.dart';
import 'package:food_delivery_application/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:food_delivery_application/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/login_usecase.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:food_delivery_application/features/home/presentation/view_model/home_cubit.dart';
import 'package:food_delivery_application/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:food_delivery_application/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}

_initOnboardingScreenDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(getIt<LoginBloc>()),
  );
}
