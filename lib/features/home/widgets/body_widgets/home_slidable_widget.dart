import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/platform/device_verion.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/edit/presentation/todo_edit_screen.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_todo_card.dart';

class HomeSlidableWidget extends StatelessWidget {
  final TodoModel todo;
  final int index;
  const HomeSlidableWidget({
    super.key,
    required this.todo,
    required this.index,
  });

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
              onPressed: (_) {
                /// ?? WANT TO IMPLEMENT HERE CARTEGORY SELECTION PROCESS
                context.read<SelectcategoryCubit>().selectCategoryById(
                  todo.categoryId,
                );
                triggerBottomSheet(context);
              },
              label: "Edit",
              icon: Icons.edit,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),

            SlideableActionWidget(
              onPressed: (_) {
                int id = (context.read<HomeBloc>().state as LoadedCategoryState)
                    .selectedCategories
                    .id;
                debugPrint("Id: $id");
                context.read<TodoBloc>().add(
                  DeleteTodoEvent(todoId: todo.id, filterBy: id),
                );
              },
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

  void triggerBottomSheet(BuildContext context) {
    if (DeviceProvider.of(context)) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 1,
          minChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => TodoEditScreenAndroid11(
            controller: scrollController,
            todoModel: todo,
            key: const ValueKey("todo_edit_screen_holder-android11"),
          ),
        ),
      );
    } else {
      showCupertinoSheet(
        context: context,
        builder: (_) => TodoEditScreen(
          todoModel: todo,
          key: const ValueKey("todo_edit_screen_holder"),
        ),
      );
    }
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
