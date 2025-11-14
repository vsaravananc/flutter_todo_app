import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/controller/todo_controller/domain/todo_domain.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ReadListDomain readAllListOfTodos;
  final ReadListDomain fetchTodoList;
  final UpdateTodoDoDomain updateTodo;
  TodoBloc({
    required this.readAllListOfTodos,
    required this.updateTodo,
    required this.fetchTodoList,
  }) : super(TodoInitial(todoList: const [])) {
    on<GetAllTodoEvent>(
      (event, emit) => readAllListOfTodos.trigger(event, emit, state),
    );
    on<UpdateTodoEvent>((event, emit) async {
      bool isUpdated = await updateTodo.trigger(event, emit, state);
      if (isUpdated && event.categoryId == 0) {
        add(GetAllTodoEvent());
      } else {
        add(FilterTodoEvent(categoryId: event.categoryId));
      }
    });
    on<FilterTodoEvent>(
      (event, emit) => fetchTodoList.trigger(event, emit, state),
    );
  }
}
