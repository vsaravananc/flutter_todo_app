


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';

class SelectcategoryCubit extends Cubit<CategoryModel> {
  SelectcategoryCubit(): super(const CategoryModel(id: 1, name: "All"));

  void selectCategory(CategoryModel categoryModel) {
    emit(categoryModel);
  }

  int id(){
    return state.id;
  }
  
}