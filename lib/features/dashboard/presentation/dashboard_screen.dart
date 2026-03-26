import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';
import 'package:todoapp/controller/dashboard_controller_cubit/dashboard_cubit.dart';
import 'package:todoapp/features/analytics/presentation/analytics_screen.dart';
import 'package:todoapp/features/dashboard/widgets/bottom_navigation_widget.dart';
import 'package:todoapp/features/home/presentation/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: dashBoardScreens(state),
          bottomNavigationBar: BottomNavigationWidget(
            key: const ValueKey("bottom_navigation_custom"),
            currentIndex: state,
            onTap: (index) {
              if (index == 1) {
                context.read<AnalysticBloc>().add(AnalysticGetData());
              }
              context.read<DashboardCubit>().setCurrentIndex(index);
            },
          ),
        );
      },
    );
  }

  Widget dashBoardScreens(int index) => switch (index) {
    0 => const HomeScreenContent(
      key: ValueKey("home_screen_content_dashBoard"),
    ),
    _ => const AnalyticsScreen(key: ValueKey("analytics_screen_dashboard")),
  };
}
