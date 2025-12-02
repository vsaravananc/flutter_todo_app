import 'package:flutter/material.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/features/edit/widget/todo/todo_body_widget.dart';
import 'package:todoapp/features/edit/widget/category/card/vertical_more_widget.dart';

class TodoEditScreen extends StatelessWidget {
  final TodoModel todoModel;
  const TodoEditScreen({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.onTertiary,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TodoEditHeader(
                key: const ValueKey("todo_header_holder"),
                todo: todoModel,
              ),
              TodoBodyWidget(
                key: const ValueKey("todo_body_widget_holder"),
                todoModel: todoModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// TODOEDITSCREEN CLASS: for android 11 below
///
class TodoEditScreenAndroid11 extends StatelessWidget {
  final TodoModel todoModel;
  final ScrollController controller;
  const TodoEditScreenAndroid11({
    super.key,
    required this.todoModel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(0),
      controller: controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoEditHeader(
              key: const ValueKey("todo_header_holder-android11"),
              todo: todoModel,
            ),
            TodoBodyWidget(
              key: const ValueKey("todo_body_widget_holder-android11"),
              todoModel: todoModel,
            ),
          ],
        ),
      ),
    );
  }
}

///
///  TODOEDITHEADER CLASS: it have two things one for close the current bottom sheet and the another one
/// for change the status and delete
///

class TodoEditHeader extends StatelessWidget {
  final TodoModel todo;
  const TodoEditHeader({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
          VerticalMoreWidget(
            todo: todo,
            key: const ValueKey('todo_edit_header_vertical_more'),
          ),
        ],
      ),
    );
  }
}
