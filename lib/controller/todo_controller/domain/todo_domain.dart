import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/controller/todo_controller/data/use_case/todo_data.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';

abstract class TodoDomain {}

abstract class ReadListDomain<T> implements TodoDomain {
  Future<void> trigger(T event, Emitter<TodoState> emit, TodoState state);
}

abstract class InsertTodoDomain<T, R> implements TodoDomain {
  Future<R> trigger(T event, Emitter<TodoState> emit, TodoState state);
}

abstract class WriteTodoDomain<T> implements TodoDomain {
  Future<bool> trigger(T event, Emitter<TodoState> emit, TodoState state);
}

class FetchAllTodoDomain extends ReadListDomain<GetAllTodoEvent> {
  final ReadListOfTodoData fetchAllTodo;
  FetchAllTodoDomain({required this.fetchAllTodo});
  @override
  Future<void> trigger(event, Emitter<TodoState> emit, TodoState state) async {
    try {
      List<TodoModel> value = await fetchAllTodo.trigger(null);
      emit(AllTodoList(todoList: value));
    } on ErrorHandelingService catch (e) {
      emit(ErrorTodo(errorType: e.errorType, message: e.message));
    } catch (e) {
      emit(
        ErrorTodo(
          errorType: ErrorType.someThingWentException,
          message: "Something went wrong",
        ),
      );
    }
  }
}

class UpdateTodoDoDomain extends WriteTodoDomain<UpdateTodoEvent> {
  final WriteTodoData updateTodo;
  UpdateTodoDoDomain({required this.updateTodo});
  @override
  Future<bool> trigger(event, Emitter<TodoState> emit, TodoState state) async {
    return await updateTodo.trigger(event.todoId, event.todo);
  }
}

class FetchFilterTodoDomain extends ReadListDomain<FilterTodoEvent> {
  final ReadListOfTodoData fetchAllTodo;
  FetchFilterTodoDomain({required this.fetchAllTodo});
  @override
  Future<void> trigger(event, Emitter<TodoState> emit, TodoState state) async {
    try {
      List<TodoModel> value = await fetchAllTodo.trigger(event.categoryId);
      emit(FilterTodoList(todoList: value));
    } on ErrorHandelingService catch (e) {
      emit(ErrorTodo(message: e.message, errorType: e.errorType));
    } catch (e) {
      emit(
        ErrorTodo(
          errorType: ErrorType.someThingWentException,
          message: "Something went wrong",
        ),
      );
    }
  }
}

class AddTodoDomain extends InsertTodoDomain<AddTodoEvent, bool> {
  final AddTodoData insertTodo;
  AddTodoDomain({required this.insertTodo});
  @override
  Future<bool> trigger(event, Emitter<TodoState> emit, TodoState state) async {
    try {
      debugPrint(event.categoryId.toString());
      debugPrint(event.todo);
      return await insertTodo.trigger({
        "title": event.todo,
        "description": "",
        "categoryId": event.categoryId,
        "isDone": 0,
        "createdAt": DateTime.now().toIso8601String(),
        "closedAt": "",
      });
    } catch (e) {
      return false;
    }
  }
}
