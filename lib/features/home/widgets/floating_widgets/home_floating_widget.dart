import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/platform/device_bottom.dart';
import 'package:todoapp/core/platform/device_verion.dart';
import 'package:todoapp/core/services/app_show_case.dart';
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
        child: Showcase(
          key: AppShowCase.addTask,
          descriptionTextAlign: TextAlign.center,
          title: "Add New Task",
          description:
              "Create your own task to get things done and stay organized.",
          child: BlocListener<TodoBloc, TodoState>(
            listener: (context, state) {
              context.read<AnalysticBloc>().add(AnalysticGetData());
            },
            child: FloatingActionButton(
              key: const ValueKey('home-floating-action-button-add-todo'),
              splashColor: Theme.of(context).colorScheme.secondary,
              elevation: 2,
              shape: const CircleBorder(),
              onPressed: () {
                triggerBottomSheet(context);
                // SystemChrome.setSystemUIOverlayStyle(

                // );
              },
              child: Icon(
                Icons.add,
                color: LightColors.secondaryTextColor,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void triggerBottomSheet(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.onTertiary,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    if (DeviceProvider.of(context)) {
      showModalBottomSheet(
        context: context,
        builder: (_) => const TaskTodoBottomsheet(
          key: const ValueKey("todo_edit_screen_holder-android11"),
        ),
      );
    } else {
      showCupertinoSheet(
        context: context,
        builder: (_) => const Wrap(
          runAlignment: WrapAlignment.end,
          children: [
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
              ),
              child: TaskTodoBottomsheet(
                key: const ValueKey("todo_edit_screen_holder"),
              ),
            ),
          ],
        ),
      );
    }
  }
}

///
/// TASKTODORWIDGET CLASS : HERE THE USER CAN ADD A TASK AND SELECT THE CATEGORY
///

class TaskTodoBottomsheet extends StatelessWidget {
  const TaskTodoBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomValue = DeviceBottom.of(context);

    return Container(
      key: const ValueKey('Task-todo-bottomsheet-container'),
      constraints:  BoxConstraints(minHeight: 135 + bottomValue, maxHeight: 155 + bottomValue),
      padding:  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5 + bottomValue),
      margin: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).colorScheme.onTertiary,
      ),
      child: const HomeFloatingBottomTaskWidget(
        key: ValueKey('home-floating-bottom-task-widget-layer'),
      ),
    );
  }
}
