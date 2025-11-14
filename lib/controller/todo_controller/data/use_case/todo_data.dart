import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';

abstract class TodoData {}

abstract class ReadListOfTodoData<T> implements TodoData {
  Future<T> trigger(int? categoryId);
}

abstract class WriteTodoData implements TodoData {
  Future<bool> trigger(int todoId, Map<String, dynamic> data);
}

class FetchAllTodoData extends ReadListOfTodoData<List<TodoModel>> {
  final Database database;
  FetchAllTodoData({required this.database});
  @override
  Future<List<TodoModel>> trigger(int? categoryId) async {
    try {
      if (categoryId != null) {
        final List<Map<String, dynamic>> result = await database.query(
          'todos',
          where: 'categoryId = ?',
          whereArgs: [categoryId],
        );
        return await compute(_listOfTodoModel, result);
      } else {
        final List<Map<String, dynamic>> result = await database.query('todos');
        return await compute(_listOfTodoModel, result);
      }
    } on FormatException catch (_) {
      throw ErrorHandelingService(
        message:
            "We couldn’t read your Task data correctly. Please restart the app or try again.",
        errorType: ErrorType.formateException,
      );
    } on TypeError catch (e) {
      debugPrint("Error: $e");
      throw ErrorHandelingService(
        message:
            "Something went wrong while loading your Task. Please try again later.",
        errorType: ErrorType.typeErrorException,
      );
    } catch (e) {
      throw ErrorHandelingService(
        message: "Something went wrong. Please try again later.",
        errorType: ErrorType.someThingWentException,
      );
    }
  }
}

class UpdateTodoData extends WriteTodoData {
  final Database database;
  UpdateTodoData({required this.database});
  @override
  Future<bool> trigger(int todoId, Map<String, dynamic> data) async {
    try {
      final int result = await database.update(
        'todos',
        data,
        where: 'id = ?',
        whereArgs: [todoId],
      );
      return result == 1;
    } catch (_) {
      return false;
    }
  }
}


List<TodoModel> _listOfTodoModel(List<Map<String, dynamic>> data) {
  return data.map((e) => TodoModel.fromJson(json: e)).toList();
}
