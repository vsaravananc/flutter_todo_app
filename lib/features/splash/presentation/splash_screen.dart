import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/features/home/bloc/home_bloc_bloc.dart';
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
    context.read<HomeBloc>().add(LoadCategoryEvent());
    changeTheme();
    super.initState();
  }

  Future<void> changeTheme() async {
    await Future.delayed(const Duration(seconds: 2));
    isDark.value = !isDark.value;
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.welcomScreen,
        (_) => true,
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
