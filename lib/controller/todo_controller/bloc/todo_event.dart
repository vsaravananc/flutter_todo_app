part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetAllTodoEvent extends TodoEvent {}

class FilterTodoEvent extends TodoEvent {
  final int categoryId;
  FilterTodoEvent({required this.categoryId});
}

class AddTodoEvent extends TodoEvent {
  final String todo;
  final int categoryId;
  AddTodoEvent({required this.todo, required this.categoryId});
}

class UpdateTodoEvent extends TodoEvent {
  final Map<String, dynamic> todo;
  final int todoId;
  final int categoryId;
  UpdateTodoEvent({
    required this.todo,
    required this.todoId,
    required this.categoryId,
  });
}

