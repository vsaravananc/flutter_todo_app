import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';
import 'package:todoapp/core/enum/task_enum.dart';
import 'package:todoapp/features/analytics/widgets/task_card_widget.dart';

class TaskOverviewWidget extends StatelessWidget {
  const TaskOverviewWidget({super.key});

  static const double _spacingHorizontal = 10;
  static const double _spacingVertical = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
      child: Column(
        spacing: _spacingVertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tasks Overview", style: Theme.of(context).textTheme.titleLarge),
          BlocBuilder<AnalysticBloc, AnalysticState>(
            builder: (context, state) {
              if (state is AnalysticLoaded) {
                return Row(
                      spacing: _spacingHorizontal,
                      children: [
                        TaskCardWidget(
                          numberOfTask: state.completedTask,
                          statu: TaskEnum.Completed,
                        ),
                        TaskCardWidget(
                          numberOfTask: state.pendingTask,
                          statu: TaskEnum.Pending,
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(duration: const Duration(milliseconds: 450))
                    .move(
                      begin: const Offset(0, 8),
                      end: const Offset(0, 0),
                      duration: const Duration(milliseconds: 450),
                    );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}


/**
 * 
 * const Row(
            spacing: _spacingHorizontal,
            children: [
              TaskCardWidget(numberOfTask: 2, statu: TaskEnum.Completed),
              TaskCardWidget(numberOfTask: 20, statu: TaskEnum.Pending),
            ],
          ),
 */