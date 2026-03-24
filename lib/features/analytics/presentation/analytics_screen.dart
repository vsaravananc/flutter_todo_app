import 'package:flutter/material.dart';
import 'package:todoapp/features/analytics/widgets/pi_chart_widget.dart';
import 'package:todoapp/features/analytics/widgets/task_overview_widget.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_floating_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TaskOverviewWidget(),
            Container(
              margin: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const PiChartWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: const HomeFloatingWidget(
        key: const ValueKey('home-floating-action-button-analytics'),
      ),
    );
  }
}
