part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {
  final List todoList;
  TodoInitial({required this.todoList});
}

class AllTodoList extends TodoState {
  final List<TodoModel> todoList;
  AllTodoList({required this.todoList});
}

class FilterTodoList extends TodoState {
  final List<TodoModel> todoList;
  FilterTodoList({required this.todoList});
}
