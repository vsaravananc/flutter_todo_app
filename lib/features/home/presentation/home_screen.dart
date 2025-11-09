import 'package:flutter/material.dart';
import 'package:todoapp/features/home/widgets/home_category_header.dart';

///
///  FILE_PURPOSE: HOME SCREEN
///

///
///  HomeScreen_PURPOSE: ROOT OF THE HOME SCREEN
///

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      key: ValueKey('HOME-screen'),
      body: HomeScreenAnimation(key: ValueKey('HOME-screen-animation')),
    );
  }
}

///
///  HomeScreenANIMATION_PURPOSE: HOME SCREEN ANIMATION
///

class HomeScreenAnimation extends StatefulWidget {
  const HomeScreenAnimation({super.key});

  @override
  State<HomeScreenAnimation> createState() => _HomeScreenAnimationState();
}

class _HomeScreenAnimationState extends State<HomeScreenAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final List<double> stops = const [0.0, 0.5, 0.6, 1];
  final FractionalOffset fractionalOffset = const FractionalOffset(0.95, 0.5);
  final List<Color> colors = const [
    Colors.white,
    Colors.white,
    Colors.transparent,
    Colors.transparent,
  ];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      animationBehavior: AnimationBehavior.normal,
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,

      builder: (context, child) {
        return RepaintBoundary(
          key: const ValueKey('repaint-boundary'),
          child: ShaderMask(
            key: const ValueKey('shader-mask'),
            blendMode: BlendMode.dstIn,
            shaderCallback: (rect) {
              return RadialGradient(
                radius: animationController.value * 5,
                colors: colors,
                stops: stops,
                center: fractionalOffset,
              ).createShader(rect);
            },
            child: child,
          ),
        );
      },
      child: const HomeScreenContent(
        key: const ValueKey('HOME-screen-content'),
      ),
    );
  }
}

///
///  HomeScreenCONTENT_PURPOSE: HOME SCREEN CONTENT
///

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      key: const ValueKey('HOME-screen-content'),
      appBar: const HomeCategoryHeader( key: const ValueKey('home-category-header')),
      body: const Center(child: Text('HOME Screen')),
    );
  }
}
