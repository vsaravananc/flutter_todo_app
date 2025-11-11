part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

class InitialCategoryState extends HomeBlocState {}

class LoadedCategoryState extends HomeBlocState {
  final List<CategoryModel> categories;
  final CategoryModel selectedCategories;

  LoadedCategoryState({
    required this.categories,
    required this.selectedCategories,
  });

  LoadedCategoryState copyWith(
    List<CategoryModel>? categories,
    CategoryModel? selectedCategories,
  ) {
    return LoadedCategoryState(
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}

class ErrorOnLoadingCategoryState extends HomeBlocState {
  final ErrorType errorType;
  final String message;

  ErrorOnLoadingCategoryState({required this.errorType, required this.message});
}
