import 'package:flutter/material.dart';

class HomeTodoCardWidget extends StatelessWidget {
  final int index;
  const HomeTodoCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(6),
      ),
      height: 50,
      child: Row(
        children: [
          const CheckBoxHomeTodoCardWidget(
            key: ValueKey('checkbox-home-todo-card-widget'),
          ),
          const TitleHomeTodoCardWidget(
            key: ValueKey('title-home-todo-card-widget'),
          ),
          ReorderHomeTodoCardWidget(index: index),
        ],
      ),
    );
  }
}

///
/// CHECKBOXHOMETODOCARDWIDGET CLASS: TO MAKE THE TODO IS COMPLETED
///

class CheckBoxHomeTodoCardWidget extends StatelessWidget {
  const CheckBoxHomeTodoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      key: const ValueKey('checkbox-home-todo-card-widget-checkbox'),
      value: false,
      onChanged: (_) {},
    );
  }
}

///
/// TITLEHOMETODOCARDWIDGET CLASS: TO SHOW THE TITLE OF THE TODOWidget
///

class TitleHomeTodoCardWidget extends StatelessWidget {
  const TitleHomeTodoCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        key: const ValueKey('title-home-todo-card-widget-title-shower'),
        "I have want to finish my work ",
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

///
/// REORDERABLEDRAGSTARTLISTENER CLASS: TO MAKE THE TODO IS COMPLETED
///

class ReorderHomeTodoCardWidget extends StatelessWidget {
  final int index;
  const ReorderHomeTodoCardWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      key: const ValueKey('reorderable-drag-start-listener'),
      index: index,
      child: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.drag_handle_rounded,
          key: ValueKey('reorderable-drag-start-listener-icon-drag-handle'),
        ),
      ),
    );
  }
}
