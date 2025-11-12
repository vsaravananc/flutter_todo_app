part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetAllTodoEvent extends TodoEvent {}

class FilterTodoEvent extends TodoEvent {}

