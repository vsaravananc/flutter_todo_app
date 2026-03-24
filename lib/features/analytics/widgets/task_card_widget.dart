import 'package:flutter/material.dart';
import 'package:todoapp/core/enum/task_enum.dart';
import 'package:todoapp/core/extension/task_extension.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskEnum statu;
  final int numberOfTask;
  const TaskCardWidget({
    super.key,
    this.statu = TaskEnum.Pending,
    required this.numberOfTask,
  });

  static const double _height = 110;
  static const double _radius = 16;
  static const double _spacingHorizontal = 5;

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      height: _height,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        spacing: _spacingHorizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$numberOfTask", style: Theme.of(context).textTheme.titleLarge),
          Text(
            "${statu.uiName} Tasks",
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
    if (statu == TaskEnum.Pending) {
      child = Expanded(
        child: Stack(
          children: [
            child,
            Positioned(
              top: 0,
              right: 0,
              child: Tooltip(
                message: "Total check list.",
                child: IconButton(
                  onPressed: () {
                    debugPrint("taped");
                  },
                  icon: const Icon(Icons.info_outlined),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      child = Expanded(child: child);
    }
    return child;
  }
}
