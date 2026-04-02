import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/analystic_bloc/bloc/analystic_bloc.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/core/services/shared_preference_services.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/splash/widget/splash_animation_widget.dart';
import 'package:todoapp/features/splash/widget/splash_logo_widget.dart';

///
///  FILE_PURPOSE: SPLASH SCREEN
///
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ValueNotifier<bool> isDark = ValueNotifier<bool>(false);

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    context.read<HomeBloc>().add(LoadCategoryEvent());
    context.read<TodoBloc>().add(GetAllTodoEvent());
    context.read<AnalysticBloc>().add((AnalysticGetData()));
    changeTheme();
    super.initState();
  }

  Future<void> changeTheme() async {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: LightColors.tertiaryBackgroundColor
    ));
    bool isLoged = SharedPreferenceServices.instance.isLogedIN(
      key: "IS_LOGED_IN",
    );
    await Future.delayed(const Duration(seconds: 2));
    isDark.value = !isDark.value;
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        isLoged ? Routes.dashboardScreen : Routes.welcomScreen,
        (_) => false,
      );
    }
  }

  @override
  void dispose() {
    isDark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('splash-screen'),
      body: Center(
        child: Row(
          key: const ValueKey('splash-row'),
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SplashLogo(key: ValueKey('splash-logo')),
            RepaintBoundary(
              child: SplashAnimationAppWidget(
                isDark: isDark,
                key: const ValueKey('splash-animation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
