import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/core/themes/font_family.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_slidable_widget.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_todo_list.dart';

///
///  FILE_PURPOSE: HOME CHOICE CHIP TO SELECT ANY CATEGORY
///

class HomeChoiceChip extends StatefulWidget {
  final CategoryModel categoryModel;
  final bool isSelected;
  final VoidCallback? onSelected;
  const HomeChoiceChip({
    super.key,
    required this.isSelected,
    this.onSelected,
    required this.categoryModel,
  });

  @override
  State<HomeChoiceChip> createState() => _HomeChoiceChipState();
}

class _HomeChoiceChipState extends State<HomeChoiceChip> {
  late final ExpansibleController controller;
  @override
  void initState() {
    controller = ExpansibleController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant HomeChoiceChip oldWidget) {
    if (oldWidget.isSelected != widget.isSelected) {
      if (widget.isSelected) {
        controller.expand();
      } else {
        controller.collapse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
      color: LightColors.textColor,
      fontFamily: FontFamily.openSans,
      fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w400,
    );

    return GestureDetector(
      onTap: () {
        widget.onSelected?.call();
        if (widget.isSelected) {
          controller.toggle();
        }
      },
      child: Expansible(
        animationStyle: const AnimationStyle(
          duration: Duration(milliseconds: 150),
        ),
        headerBuilder: (context, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final value = animation.value;
              return SizedBox(
                height: 45,
                child: Row(
                  spacing: 8,
                  children: [
                    Transform.rotate(
                      angle: value * (3.1415926535 / 2),
                      child: Transform.scale(
                        scale: 1.0 + (0.04 * value),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowRight01,
                          color: textStyle.color,
                          strokeWidth: widget.isSelected ? 1.8 : 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: textStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: Text(widget.categoryModel.name),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {},
                      child: Transform.scale(
                        scale: 1.0 + (0.03 * value),
                        child: const SizedBox(
                          height: 30,
                          width: 30,
                          child: Padding(
                            padding: EdgeInsets.all(3),
                            child: HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        controller: controller,

        bodyBuilder: (context, animation) {
          return BlocBuilder<TodoBloc, TodoState>(
            builder: (c, todos) {
              if (todos is ErrorTodo) {
                return Center(
                  child: Text(
                    todos.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    key: const ValueKey(
                      'reorderable-state-changer-widget-text',
                    ),
                  ),
                );
              } else if (todos is LoadingTodoList) {
                return Align(
                  alignment: const AlignmentDirectional(-0.75, 0.0),
                  child: Text(
                    'Searching for this topic..',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: LightColors.hintColor,
                    ),
                  ),
                );
              } else {
                return (todos is TodoStateWithList && todos.todoList.isNotEmpty)
                    ? FadeTransition(
                        opacity: animation,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return HomeSlidableWidget(
                              todo: todos.todoList[index],
                              index: index,
                              key: ValueKey(index),
                            );
                          },
                          itemCount: todos.todoList.length,
                        ),
                      )
                    : FadeTransition(
                        opacity: animation,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Align(
                            alignment: const AlignmentDirectional(-0.75, 0.0),
                            child: Text(
                              'No page inside',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      );
              }
            },
          );
        },
      
      ),
    );
  }
}
