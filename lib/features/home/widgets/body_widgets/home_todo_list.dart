import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/images/images.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_slidable_widget.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_todo_card.dart';

class HomeTodoListWidget extends StatefulWidget {
  const HomeTodoListWidget({super.key});

  @override
  State<HomeTodoListWidget> createState() => _HomeTodoListWidgetState();
}

class _HomeTodoListWidgetState extends State<HomeTodoListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 400), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: const SlidableTapOutSideWidget(
          key: const ValueKey('slidable-tap-outside-widget'),
        ),
      ),
    );
  }
}

///
/// SLIDABLETAPOUTSIDEWIDGET CLASS: IT WILL ALOW THE USER TO TAP ANY WERE TO CLOSE THE CURRENT SLIDABLE OPTIONS
///

class SlidableTapOutSideWidget extends StatelessWidget {
  const SlidableTapOutSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      child: ReOrderableStateChangerWidget(
        key: const ValueKey('reorderable-state-changer-widget'),
      ),
    );
  }
}

///
/// REORDERABLESTATECHANGER CLASS: IT REPLACE THE LIST BY USER PREFERENCES
///

class ReOrderableStateChangerWidget extends StatelessWidget {
  const ReOrderableStateChangerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      builder: (c, todos) {
        if (todos is ErrorTodo) {
          return Center(
            child: Text(
              todos.message,
              style: Theme.of(context).textTheme.bodyMedium,
              key: const ValueKey('reorderable-state-changer-widget-text'),
            ),
          );
        } else {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child: (todos is TodoStateWithList && todos.todoList.isNotEmpty)
                ? ReorderableStateCahgeWidget(todos: todos)
                : const EmptListWidget(),
          );
        }
      },
      listener: (c, state) {},
    );
  }
}

///
/// PROXYDECORATEWIDGET CLASS: IT DECORATE EACH CARD WHEN THE USER DRAG THE CARD
///

class ProxyDecorateWidget extends StatelessWidget {
  final int index;
  final TodoModel todoModel;
  const ProxyDecorateWidget({
    super.key,
    required this.index,
    required this.todoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const ValueKey('proxy-decorate-widget'),
      color: Colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6),
        side: const BorderSide(color: Colors.white12, width: 1.3),
      ),
      child: HomeTodoCardWidget(index: index, todo: todoModel),
    );
  }
}

///
/// REORDERABLESTATECHANGERWIDGET CLASS: IT REPLACE THE LIST BY USER PREFERENCES
///

class ReorderableStateCahgeWidget extends StatelessWidget {
  final TodoStateWithList todos;
  const ReorderableStateCahgeWidget({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      physics: const ClampingScrollPhysics(),
      footer: const SizedBox(height: 10),
      clipBehavior: Clip.none,
      key: const ValueKey('reorderable-listview'),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: todos.todoList.length,
      onReorder: (oldIndex, newIndex) {},
      proxyDecorator: (child, index, animation) {
        return ProxyDecorateWidget(
          index: index,
          todoModel: todos.todoList[index],
        );
      },
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        return HomeSlidableWidget(
          todo: todos.todoList[index],
          index: index,
          key: ValueKey(index),
        );
      },
    );
  }
}

///
/// EMPTYLISTWIDGET CLASS: IF THE LIST IS EMPTY SHOW THIS WIDGET
///

class EmptListWidget extends StatelessWidget {
  const EmptListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 20,
        children: [
          Image.asset(
            Images.noTask,
            height: 150,
            width: 150,
            color: isDark ? DarkColors.textColor : LightColors.textColor,
          ),
          Text(
            "No task in this Category\n Click + to create your task.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
