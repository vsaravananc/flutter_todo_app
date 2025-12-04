import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_edit_logic/domain/todo_edit_domain.dart';

class TodoEditController {
  static TodoEditController? instance;
  TodoEditController._(this.editDomain);
  final TodoEditDomain editDomain;
  factory TodoEditController.init({required TodoEditDomain todoEditDomain}) {
    instance ??= TodoEditController._(todoEditDomain);
    return instance!;
  }

  Future<void> updateTodo({
    required String id,
    required String value,
    required String key,
    required BuildContext context,
  }) async {
    /***
     * 
     * here i have change the function form .then to seprate function 
     * using context.mounted if it true the i calling fetchRelatedstufs
     * 
     */
    await editDomain.updateTodo(id: id, key: key, value: value);
    if (context.mounted) {
      fetchRelatedStufs(context);
    }
  }

  void fetchRelatedStufs(BuildContext context) {
    final categoryModel =
        (context.read<HomeBloc>().state as LoadedCategoryState)
            .selectedCategories;
    context.read<TodoBloc>().add(FilterTodoEvent(categoryId: categoryModel.id));
  }
}
