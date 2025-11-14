part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

abstract class TodoStateWithList extends TodoState {
  final List<TodoModel> todoList;

  TodoStateWithList({required this.todoList});
}

class TodoInitial extends TodoStateWithList {
  TodoInitial({required super.todoList});
}

class AllTodoList extends TodoStateWithList {
  AllTodoList({required super.todoList});
}

class FilterTodoList extends TodoStateWithList {
  FilterTodoList({required super.todoList});
}


class ErrorTodo extends TodoState {
  final String message;
  final ErrorType errorType;

  ErrorTodo({required this.message, required this.errorType});
}
