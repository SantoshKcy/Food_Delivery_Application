import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:food_delivery_application/features/category/domain/entity/category_entity.dart';
import 'package:food_delivery_application/features/category/domain/usecase/get_all_categories_usecase.dart';


part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetAllCategoriesUseCase _getAllCategoriesUseCase;

  CategoryBloc({
    required GetAllCategoriesUseCase getAllCategoriesUseCase,
  })  : _getAllCategoriesUseCase = getAllCategoriesUseCase,
        super(CategoryState.initial()) {
    on<LoadCategories>(_onLoadCategories);

    // Automatically load categories when the bloc is created
    add(LoadCategories());
  }

  Future<void> _onLoadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllCategoriesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (categories) => emit(state.copyWith(isLoading: false, categories: categories)),
    );
  }
}
