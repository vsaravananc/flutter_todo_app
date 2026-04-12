import 'dart:ui';
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
      child: Material(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: Theme.of(
            context,
          ).colorScheme.secondary.withValues(alpha: 0.2),
          onTap: () {
            final widgetinfo = widgetInfo(context);

            showDialog(context, widgetinfo.$1, widgetinfo.$2);
          },
          child: SizedBox(
            key: ValueKey('todo-item-${todo.id}'),
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
        ),
      ),
    );
  }

  (Offset, Size) widgetInfo(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final tapPosition = renderBox.localToGlobal(Offset.zero);
    final centerPosition = Offset(
      MediaQuery.sizeOf(context).width / 2,
      MediaQuery.sizeOf(context).height / 2,
    );
    final position = tapPosition + Offset(size.width / 2, size.height / 2);
    final delta = position - centerPosition;
    return (delta, size);
  }

  void showDialog(BuildContext context, Offset delta, Size size) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black12,
      context: context,
      pageBuilder: (_, __, ___) => const SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final t = animation.value;
        final screenSize = MediaQuery.sizeOf(context);
        final offset = Offset(delta.dx * (1 - t), delta.dy * (1 - t));
        final left = lerpDouble(45, 12, t);
        final height = lerpDouble(size.height, 200, t);
        final width = lerpDouble(
          size.width,
          (screenSize.width > 600)
              ? screenSize.width / 2
              : screenSize.width - 24,
          t,
        );
        return Transform.translate(
          offset: offset,
          child: Center(
            child: Container(
              height: height,
              constraints: const BoxConstraints(maxHeight: 200),
              padding: EdgeInsets.only(
                left: left!,
                right: 12,
                bottom: 12,
                top: 12,
              ),
              width: width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(lerpDouble(8, 12, t)!),
              ),
              child: Text(
                todo.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        );
      },
    );
  }
}

///
/// CHECKBOXHOMETODOCARDWIDGET CLASS: TO MAKE THE TODOISCOMPLETED
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
          Map<String, dynamic> data = BuilderService().markIsDone(value).build;
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
