import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial(todoList: const [])) {
    on<GetAllTodoEvent>((event, emit) => {});
    on<FilterTodoEvent>((event, emit) => {});
  }
}
