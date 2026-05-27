import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/controller/todo_controller/domain/todo_domain.dart';
import 'package:todoapp/core/permissions/notification_permission.dart';
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
      _fetchTheList(isUpdated, event.categoryId);
    });

    on<FilterTodoEvent>(
      (event, emit) => fetchTodoList.trigger(event, emit, state),
    );

    on<AddTodoEvent>((event, emit) async {
      _scheduleNotification(reminderAt, event);
      bool isUpdated = await insertTodo.trigger(event, emit, state);
      _instedNotification(event);
      reminderAt = "";
      _fetchTheList(isUpdated, event.filterBy);
    });

    on<DeleteTodoEvent>((event, emit) async {
      bool isDeleted = await deleteTodoDomain.trigger(event, emit, state);
      _fetchTheList(isDeleted, event.filterBy);
    });

    on<ReOrderTodoList>(
      (event, emit) => reOrderTodoDomain.trigger(event, emit, state),
    );
  }

  static String reminderAt = "";

  static void setReminderAt(DateTime value) {
    reminderAt = value.toIso8601String();
  }

  void _fetchTheList(bool isUpdated, int categoryId) {
    if (isUpdated && categoryId == 1) {
      add(GetAllTodoEvent());
    } else if (isUpdated && categoryId != 1) {
      add(FilterTodoEvent(categoryId: categoryId));
    }
  }

  void _scheduleNotification(String reminder, AddTodoEvent event) {
    if (reminder.isEmpty) return;
    final id = DateTime.now().microsecondsSinceEpoch.remainder(1000);
    NotificationPermission.scheduleNotification(
      id: id,
      title: "Reminder for ${event.todo}",
      body: "Don't forget to complete your task!",
      scheduleTime: DateTime.parse(reminderAt),
    );
  }

  void _instedNotification(AddTodoEvent event) {
    NotificationPermission.showNotification(
      id: event.categoryId,
      title: "Add Task",
      body: event.todo,
    );
  }
}
