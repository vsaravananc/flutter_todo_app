import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/controller/todo_controller/domain/todo_domain.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ReadListDomain readAllListOfTodos;
  final ReadListDomain fetchTodoList;
  final UpdateTodoDoDomain updateTodo;
  final AddTodoDomain insertTodo;
  final DeleteTodoDomain deleteTodoDomain;
  final ReOrderTodoDomain reOrderTodoDomain;
  TodoBloc({
    required this.readAllListOfTodos,
    required this.updateTodo,
    required this.fetchTodoList,
    required this.insertTodo,
    required this.deleteTodoDomain,
    required this.reOrderTodoDomain,
  }) : super(TodoInitial(todoList: const [])) { 

    on<GetAllTodoEvent>(
      (event, emit) => readAllListOfTodos.trigger(event, emit, state),
    );
    
    on<UpdateTodoEvent>((event, emit) async {
      bool isUpdated = await updateTodo.trigger(event, emit, state);
      _fetchTheList(isUpdated, event.categoryId );
    });
   
    on<FilterTodoEvent>(
      (event, emit) => fetchTodoList.trigger(event, emit, state),
    );
   
    on<AddTodoEvent>((event, emit) async {
      bool isUpdated = await insertTodo.trigger(event, emit, state);
      _fetchTheList(isUpdated, event.filterBy);
    });
   
    on<DeleteTodoEvent>((event,emit) async{
      bool isDeleted = await deleteTodoDomain.trigger(event, emit, state);
      _fetchTheList(isDeleted, event.filterBy);
    });
  
    on<ReOrderTodoList>((event,emit) => reOrderTodoDomain.trigger(event, emit, state));

  }

  void _fetchTheList(bool isUpdated, int categoryId) {
    if (isUpdated && categoryId == 1) {
      add(GetAllTodoEvent());
    } else if (isUpdated && categoryId != 1) {
      add(FilterTodoEvent(categoryId: categoryId));
    }
  }

}
