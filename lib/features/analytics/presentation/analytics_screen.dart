import 'package:flutter/material.dart';
import 'package:todoapp/features/analytics/widgets/pi_chart_widget.dart';
import 'package:todoapp/features/analytics/widgets/task_overview_widget.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_floating_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             TaskOverviewWidget(),
             PiChartWidget(),
          ],
        ),
      ),
      floatingActionButton:  HomeFloatingWidget(
        key:  ValueKey('home-floating-action-button-analytics'),
      ),
    );
  }
}
