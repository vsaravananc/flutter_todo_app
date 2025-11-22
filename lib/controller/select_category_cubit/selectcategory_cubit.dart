import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/domain.dart';

class SelectcategoryCubit extends Cubit<CategoryModel> {
  final SelectCategoryReadDomain fetchData;
  SelectcategoryCubit({required this.fetchData})
    : super(const CategoryModel(id: 1, name: "All"));

  void selectCategory(CategoryModel categoryModel) {
    emit(categoryModel);
  }

  Future<void> selectCategoryById(int id) async {
    try {
      final categoryModel = await fetchData.selectCategoryById(id);
      emit(categoryModel);
    } catch (_) {}
  }

  int id() {
    return state.id;
  }
}
