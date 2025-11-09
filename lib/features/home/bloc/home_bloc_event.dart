part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class LoadCategoryEvent extends HomeBlocEvent {}

class SelectCategoryEvent extends HomeBlocEvent {
  final CategoryModel categoryModel;
  SelectCategoryEvent({required this.categoryModel});
}
