import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';

abstract class TodoData {}

abstract class ReadListOfTodoData<T> implements TodoData {
  Future<T> trigger(int? categoryId);
}

abstract class WriteTodoData<R, I> implements TodoData {
  Future<R> trigger(int todoId, I data);
}

abstract class InsertTodoData<R, M> implements TodoData {
  Future<R> trigger(M data);
}

class FetchAllTodoData extends ReadListOfTodoData<List<TodoModel>> {
  final Database database;
  FetchAllTodoData({required this.database});
  @override
  Future<List<TodoModel>> trigger(int? categoryId) async {
    try {
      if (categoryId != null && categoryId != 1) {
        final List<Map<String, dynamic>> result = await database.query(
          'todos',
          where: 'categoryId = ?',
          orderBy: 'sortOrder DESC',
          whereArgs: [categoryId],
        );
        return await compute(_listOfTodoModel, result);
      } else {
        final List<Map<String, dynamic>> result = await database.query(
          'todos',
          orderBy: 'sortOrder DESC',
        );
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

class UpdateTodoData extends WriteTodoData<bool, Map<String, dynamic>> {
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

class AddTodoData extends InsertTodoData<bool, Map<String, dynamic>> {
  final Database database;
  AddTodoData({required this.database});
  @override
  Future<bool> trigger(Map<String, dynamic> data) async {
    try {
      final result = await database.rawQuery(
        'SELECT MAX(sortOrder) as maxOrder FROM todos',
      );
      int nextOrder = ((result.first['maxOrder'] ?? 0) as int) + 1;
      data['sortOrder'] = nextOrder;

      await database.insert('todos', data);
      return true;
    } catch (e) {
      return false;
    }
  }
}

List<TodoModel> _listOfTodoModel(List<Map<String, dynamic>> data) {
  return data.map((e) => TodoModel.fromJson(json: e)).toList();
}

class DeleteTodoData extends WriteTodoData<bool, int?> {
  final Database database;
  DeleteTodoData({required this.database});
  @override
  Future<bool> trigger(int todoId, int? _) async {
    try {
      final int result = await database.delete(
        'todos',
        where: 'id = ?',
        whereArgs: [todoId],
      );
      return result == 1;
    } catch (_) {
      return false;
    }
  }
}


class ReOrderTodoData extends WriteTodoData<void,List<TodoModel>> {
  final Database database;
  ReOrderTodoData({required this.database});
  @override
  Future<void> trigger(int todoId, List<TodoModel> data) async{
    for (int i = 0; i < data.length; i++) {
      await database.update(
        'todos',
        {'sortOrder': data.length - i},
        where: 'id = ?',
        whereArgs: [data[i].id],
      );
    }
  }
  
}