part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

/// ✅ Event to load all categories
final class LoadCategories extends CategoryEvent {}
