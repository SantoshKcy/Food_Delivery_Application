// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:food_delivery_application/app/shared_prefs/token_shared_prefs.dart';
import 'package:food_delivery_application/core/network/api_service.dart';
import 'package:food_delivery_application/core/network/hive_service.dart';
import 'package:food_delivery_application/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:food_delivery_application/features/auth/data/data_source/remote_data_source/auth_remote_datasource.dart';
import 'package:food_delivery_application/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:food_delivery_application/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/login_usecase.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:food_delivery_application/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:food_delivery_application/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:food_delivery_application/features/cart/data/data_source/remote_data_source/cart_remote_data_source.dart';
import 'package:food_delivery_application/features/cart/domain/usecase/cart_use_case.dart';
import 'package:food_delivery_application/features/category/data/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:food_delivery_application/features/category/data/repository/category_remote_repository/category_remote_repository.dart';
import 'package:food_delivery_application/features/category/domain/usecase/get_all_categories_usecase.dart';
import 'package:food_delivery_application/features/category/presentation/view_model/category_bloc.dart';
import 'package:food_delivery_application/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:food_delivery_application/features/home/data/repository/home_remote_repository/home_remote_repository.dart';
import 'package:food_delivery_application/features/home/domain/usecase/get_items_by_tag_use_case.dart';
import 'package:food_delivery_application/features/home/presentation/view_model/home_bloc.dart';
import 'package:food_delivery_application/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:food_delivery_application/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:food_delivery_application/features/wishlist/data/data_source/remote_data_source/wishlist_remote_data_source.dart';
import 'package:food_delivery_application/features/wishlist/data/model/wishlist_api_model.dart';
import 'package:food_delivery_application/features/wishlist/domain/usecase/get_wishlist_item_by_user_usecase.dart';
import 'package:food_delivery_application/features/wishlist/presentation/view_model/wishlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initRegisterDependencies();
  await _initLoginDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardingScreenDependencies();
  await _initCategoryDependencies();
  await _initHomeDependencies();
  await _initCartDependencies();
  await _initWishlistDependencies();
  await _initProfileDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(
    () => HiveService(),
  );
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initRegisterDependencies() {
  // Init data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // Init repository (Updated to use AuthRemoteRepository)
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    // Use the remote repository
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthRemoteRepository>(), // Updated to use AuthRemoteRepository
  //   ),
  // );

  // getIt.registerLazySingleton<UploadImageUsecase>(
  //   () => UploadImageUsecase(
  //     getIt<AuthRemoteRepository>(), // Updated to use AuthRemoteRepository
  //   ),
  // );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(), // Updated to use AuthRemoteRepository
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthLocalRepository>(), // Updated to use AuthRemoteRepository
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    // () => LoginUseCase(
    //   getIt<AuthRemoteRepository>(), // Use AuthRemoteRepository
    //   getIt<TokenSharedPrefs>(),
    // ),
    () => LoginUseCase(
      getIt<AuthLocalRepository>(), // Use AuthRemoteRepository
      getIt<TokenSharedPrefs>(),
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

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeBloc: getIt<HomeBloc>(),
      loginUseCase: getIt<
          LoginUseCase>(), // This will fetch the already registered LoginUseCase
    ),
  );
}

_initCategoryDependencies() {
  getIt.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => CategoryRemoteRepository(
      remoteDataSource: getIt<CategoryRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<GetAllCategoriesUseCase>(
    () => GetAllCategoriesUseCase(
        categoryRepository: getIt<CategoryRemoteRepository>()),
  );

  // =========================== Bloc ===========================
  getIt.registerLazySingleton<CategoryBloc>(
    () => CategoryBloc(
      getAllCategoriesUseCase: getIt<GetAllCategoriesUseCase>(),
    ),
  );
}

_initCartDependencies() {
  getIt.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => CartRemoteRepository(
      remoteDataSource: getIt<CartRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<GetCartItemsByUserIdUseCase>(
    () => GetCartItemsByUserIdUseCase(
        cartRepository: getIt<GetCartItemsByUserIdUseCase>()),
  );

  // =========================== Bloc ===========================
  getIt.registerLazySingleton<CartBloc>(
    () => CartBloc(
      getCartItemsByUserIdUseCase: getIt<GetCartItemsByUserIdUseCase>(),
    ),
  );
}

_initWishlistDependencies() {
  getIt.registerLazySingleton<WishlistRemoteDataSource>(
    () => WishlistRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => WishlistApiModel.fromJson(
      remoteDataSource: getIt<WishlistRemoteDataSource>(),
    ),
  );

  // =========================== Usecases ===========================

  getIt.registerLazySingleton<GetWishlistByUserId>(
    () => GetWishlistByUserId(wishlistRepository: getIt<GetWishlistByUserId>()),
  );

  // =========================== Bloc ===========================
  getIt.registerLazySingleton<WishlistBloc>(
    () => WishlistBloc(
      getCartItemsByUserIdUseCase: getIt<GetCartItemsByUserIdUseCase>(),
    ),
  );
}

_initHomeDependencies() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(
      dio: getIt<Dio>(),
    ),
  );

  // ✅ Ensure HomeRemoteRepository is registered
  getIt.registerLazySingleton<HomeRemoteRepository>(
    () => HomeRemoteRepository(
      remoteDataSource: getIt<HomeRemoteDataSource>(),
    ),
  );

  // ✅ Register GetAllItemsUseCase BEFORE using it in HomeBloc

  getIt.registerLazySingleton<GetItemsByTagUseCase>(
    () => GetItemsByTagUseCase(homeRepository: getIt<HomeRemoteRepository>()),
  );

  // ✅ Register HomeBloc AFTER all dependencies are registered
  getIt.registerLazySingleton<HomeBloc>(
    () => HomeBloc(
      getItemsByTagUseCase: getIt<GetItemsByTagUseCase>(),
      categoryBloc: getIt<CategoryBloc>(),
    ),
  );
}
