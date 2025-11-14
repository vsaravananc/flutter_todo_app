import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_todo_card.dart';

class HomeSlidableWidget extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const HomeSlidableWidget({super.key, required this.todo, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Slidable(
        key: const ValueKey('slidable-widget-holder'),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.4,
          children: [
            SlideableActionWidget(
              onPressed: (_) {},
              label: "Edit",
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),

            SlideableActionWidget(
              onPressed: (_) {},
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
        child: HomeTodoCardWidget(
          todo: todo,
          index: index,
          key: const ValueKey('home-todo-card-widget-holder'),
        ),
      ),
    );
  }
}

///
/// SLIDEABLEACTIONWIDGET: IS WILL SHOW THE AVALIABLE OPTION ON RIGHT TO LEFT SLIDE
///

class SlideableActionWidget extends SlidableAction {
  const SlideableActionWidget({
    super.key,
    required super.onPressed,
    required super.label,
    required super.icon,
    required super.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      foregroundColor: Theme.of(context).brightness == Brightness.dark
          ? DarkColors.textColor
          : LightColors.textColor,
      onPressed: onPressed,
      borderRadius: BorderRadius.horizontal(
        right: label!.startsWith('Ed') ? Radius.zero : const Radius.circular(8),
        left: label!.startsWith('Ed') ? const Radius.circular(8) : Radius.zero,
      ),
      backgroundColor: backgroundColor,
      icon: icon,
      label: label,
    );
  }
}
