import 'package:bloc/bloc.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/category_controller/data/use_case/home_data.dart';

sealed class HomeDomain<T> {
  Future<void> triggerEvent(
    T event,
    Emitter<HomeBlocState> emit,
    HomeBlocState currentState,
  );
}

class LoadCategoryDomain extends HomeDomain<LoadCategoryEvent> {
  final HomeData loadCategoryData;

  LoadCategoryDomain({required this.loadCategoryData});
  @override
  Future<void> triggerEvent(
    LoadCategoryEvent event,
    Emitter<HomeBlocState> emit,
    HomeBlocState currentState,
  ) async {
    try {
      final List<CategoryModel> value = await loadCategoryData.getData();
      if (currentState is LoadedCategoryState) {
        emit(
          LoadedCategoryState(
            categories: value,
            selectedCategories: currentState.selectedCategories,
          ),
        );
      } else {
        emit(
          LoadedCategoryState(
            categories: value,
            selectedCategories: value.first,
          ),
        );
      }
    } on ErrorHandelingService catch (e) {
      emit(
        ErrorOnLoadingCategoryState(errorType: e.errorType, message: e.message),
      );
    }
  }
}

class SelectCategoryDomain extends HomeDomain<SelectCategoryEvent> {
  @override
  Future<void> triggerEvent(
    SelectCategoryEvent event,
    Emitter<HomeBlocState> emit,
    HomeBlocState currentState,
  ) async {
    if (currentState is LoadedCategoryState) {
      final updatedState = currentState.copyWith(null, event.categoryModel);
      emit(updatedState);
    }
  }
}

class AddCategoryDomain extends HomeDomain<AddCategoryEvent> {
  final HomeDomain loadCategory;
  final HomeDataInsert insertData;

  AddCategoryDomain({required this.insertData, required this.loadCategory});
  @override
  Future<void> triggerEvent(
    AddCategoryEvent event,
    Emitter<HomeBlocState> emit,
    HomeBlocState currentState,
  ) async {
    bool isInseted = await insertData.insertData(name: event.categoryName);
    if (isInseted) {
      await loadCategory.triggerEvent(LoadCategoryEvent(), emit, currentState);
    }
  }
}
