import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_bottom_task_widget.dart';

///
/// HOMEFLOATINGWIDGET CLASS: IT HELP THE USER TO TRIGGER THE TASK INPUT HOLDER
///

class HomeFloatingWidget extends StatelessWidget {
  const HomeFloatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: const ValueKey('home-floating-action-button-repaint'),
      child: AvatarGlow(
        glowCount: 1,
        glowColor: Theme.of(context).primaryColor,
        glowRadiusFactor: 0.4,
        repeat: true,
        animate: true,
        startDelay: const Duration(milliseconds: 2000),
        child: FloatingActionButton(
          key: const ValueKey('home-floating-action-button-add-todo'),
          splashColor: Theme.of(context).colorScheme.secondary,
          elevation: 2,
          shape: const CircleBorder(),
          onPressed: () => showCupertinoSheet(
            context: context,
            builder: (_) => const Wrap(
              runAlignment: WrapAlignment.end,
              children: [TaskTodoBottomsheet()],
            ),
          ),
          child: Icon(
            Icons.add,
            color: LightColors.secondaryTextColor,
            size: 30,
          ),
        ),
      ),
    );
  }
}

///
/// TASKTODORWIDGET CLASS : HERE THE USER CAN ADD A TASK AND SELECT THE CATEGORY
///

class TaskTodoBottomsheet extends StatelessWidget {
  const TaskTodoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('Task-todo-bottomsheet-container'),
      height: 100,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: const HomeFloatingBottomTaskWidget(
        key: ValueKey('home-floating-bottom-task-widget-layer'),
      ),
    );
  }
}
