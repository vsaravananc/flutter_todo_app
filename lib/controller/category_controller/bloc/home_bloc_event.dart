part of 'home_bloc_bloc.dart';

sealed class HomeBlocEvent {}

class LoadCategoryEvent extends HomeBlocEvent {}

class SelectCategoryEvent extends HomeBlocEvent {
  final CategoryModel categoryModel;
  SelectCategoryEvent({required this.categoryModel});
}

class AddCategoryEvent extends HomeBlocEvent {
  final String categoryName;
  AddCategoryEvent({required this.categoryName});
}

class UpdateCategoryEvent extends HomeBlocEvent {
  final int categoryId;
  final String categoryName;
  UpdateCategoryEvent({required this.categoryId, required this.categoryName});
}

class DeleteCategoryEvent extends HomeBlocEvent {
  final int categoryId;
  DeleteCategoryEvent({required this.categoryId});
}
