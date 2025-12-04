import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/images/images.dart';
import 'package:todoapp/core/services/app_show_case.dart';
import 'package:todoapp/core/services/builder_service.dart';

class HomeTodoCardWidget extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const HomeTodoCardWidget({
    super.key,
    required this.todo,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ReorderableDelayedDragStartListener(
      index: index,
      key: ValueKey('reorderable-delayed-drag-start-listener$index'),
      child: Container(
        key: ValueKey('todo-item-${todo.id}'),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 55,
        child: Row(
          children: [
            CheckBoxHomeTodoCardWidget(
              isChecked: todo.isDone,
              id: todo.id,
              categoryId: todo.categoryId,
              key: const ValueKey('checkbox-home-todo-card-widget'),
            ),
            TitleHomeTodoCardWidget(
              title: todo.title,
              key: const ValueKey('title-home-todo-card-widget'),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// CHECKBOXHOMETODOCARDWIDGET CLASS: TO MAKE THE TODO IS COMPLETED
///

class CheckBoxHomeTodoCardWidget extends StatefulWidget {
  final bool isChecked;
  final int id;
  final int categoryId;
  const CheckBoxHomeTodoCardWidget({
    super.key,
    required this.isChecked,
    required this.id,
    required this.categoryId,
  });

  @override
  State<CheckBoxHomeTodoCardWidget> createState() =>
      _CheckBoxHomeTodoCardWidgetState();
}

class _CheckBoxHomeTodoCardWidgetState
    extends State<CheckBoxHomeTodoCardWidget> {
  late AudioPlayer player;

  @override
  void initState() {
    player = AudioPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: AppShowCase.markasdone,
      descriptionTextAlign: TextAlign.center,
      title: "Mark As Done",
      description:
          "Finish a task? Tap to complete it and enjoy the satisfaction.",

      child: Checkbox(
        key: ValueKey(
          'checkbox-home-todo-card-widget-checkbox-${widget.isChecked}',
        ),
        value: widget.isChecked,
        onChanged: (value) {
          if (value!) player.play(AssetSource(Images.onTapSound));
          int categoryId =
              (context.read<HomeBloc>().state as LoadedCategoryState)
                  .selectedCategories
                  .id;
          Map<String, dynamic> data = BuilderService().markIsDone(value!).build;
          context.read<TodoBloc>().add(
            UpdateTodoEvent(
              todo: data,
              todoId: widget.id,
              categoryId: categoryId,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

///
/// TITLEHOMETODOCARDWIDGET CLASS: TO SHOW THE TITLE OF THE TODOWidget
///

class TitleHomeTodoCardWidget extends StatelessWidget {
  final String title;
  const TitleHomeTodoCardWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        key: ValueKey('title-home-todo-card-widget-title-$title'),
        title,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
