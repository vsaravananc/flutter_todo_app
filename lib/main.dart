import 'package:flutter/material.dart';
import 'package:todoapp/core/extension/text_style_extension.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/core/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: Routes.routed,
      title: 'Todo-App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: SplashScreenAnimation()));
  }
}

class SplashScreenAnimation extends StatefulWidget {
  const SplashScreenAnimation({super.key});

  @override
  State<SplashScreenAnimation> createState() => _SplashScreenAnimationState();
}

class _SplashScreenAnimationState extends State<SplashScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final Duration duration = const Duration(milliseconds: 400);

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  Future<void> initAnimation() async {
    _animationController = AnimationController(vsync: this, duration: duration);
    await Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _animationController.forward();
    });
    _animationController.addListener(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final curved = CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        );
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            (_animationController.status == AnimationStatus.forward ||
                    _animationController.status == AnimationStatus.completed)
                ? AnimatedSize(
                    duration: duration,
                    child: FadeTransition(
                      opacity: curved,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(-0.2, 0),
                          end: Offset.zero,
                        ).animate(_animationController),
                        child: Text(
                          "Todo App",
                          style: Theme.of(
                            context,
                          ).textTheme.headlineMedium?.ffborel,
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
