import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';
import 'package:todoapp/controller/dashboard_controller_cubit/dashboard_cubit.dart';
import 'package:todoapp/core/services/app_show_case.dart';
import 'package:todoapp/core/services/app_update.dart';
import 'package:todoapp/core/services/shared_preference_services.dart';
import 'package:todoapp/features/analytics/presentation/analytics_screen.dart';
import 'package:todoapp/features/dashboard/widgets/bottom_navigation_widget.dart';
import 'package:todoapp/features/home/presentation/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    AppUpdate.checkAndUpdate();
    if (!SharedPreferenceServices.instance.getValue(key: "SHOW_CASE")) {
      _startShowCase();
    }
  }

   void _startShowCase() {
    Future.delayed(const Duration(milliseconds: 1350), () {
      if(mounted) {
        AppShowCase.startShowCaseing(MediaQuery.sizeOf( context).width > 600);
      }
    });
    SharedPreferenceServices.instance.setValue(key: "SHOW_CASE", value: true);
    SharedPreferenceServices.instance.setValue(key: "IS_LOGED_IN", value: true);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
      );
    });
    return LayoutBuilder(
      builder: (context, constraint) {
        if (constraint.maxWidth > 600) {

          return const TableView();
        }
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

class TableView extends StatelessWidget {
  const TableView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: HomeScreenContent(
            key: ValueKey("home_screen_content_dashBoard_table_view"),
            isTablet: true,
          ),
        ),
        Expanded(
          child: AnalyticsScreen(
            key: ValueKey("analytics_screen_dashboard_table_view"),
          ),
        ),
      ],
    );
  }
}
