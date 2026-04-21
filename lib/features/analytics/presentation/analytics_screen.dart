import 'package:flutter/material.dart';
import 'package:todoapp/features/analytics/widgets/pi_chart_widget.dart';
import 'package:todoapp/features/analytics/widgets/task_overview_widget.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_floating_widget.dart';

class AnalyticsScreen extends StatelessWidget {
  final bool isTablet;
  const AnalyticsScreen({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: !isTablet ? 12.0 : 0, right: 12.0, ),
          child: const Column(spacing: 8,children: [TaskOverviewWidget(), PiChartWidget()]),
        ),
      ),
      floatingActionButton: !isTablet
          ? null
          : const HomeFloatingWidget(
              key: ValueKey('home-floating-action-button-analytics'),
            ),
    );
  }
}
