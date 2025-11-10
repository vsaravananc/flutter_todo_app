import 'package:flutter/material.dart';
import 'package:todoapp/features/welcome/widget/welcome_get_started_button_widget.dart';
import 'package:todoapp/features/welcome/widget/welcome_indicator_screen.dart';
import 'package:todoapp/features/welcome/widget/welcome_screen_holder_widget.dart';

///
///  FILE_PURPOSE: WELCOME SCREEN
///

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> position;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    position = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const ValueKey('welcome-screen'),
      body: SlideTransition(
        position: position,
        child: FadeTransition(
          key: const ValueKey('fade-transition'),
          opacity: animationController,
          child: const WelcomeAcutalScreen(
            key: const ValueKey('welcome-acutal-screen'),
          ),
        ),
      ),
    );
  }
}

///
///  FILE_PURPOSE: WELCOME ACUTAL SCREEN
///

class WelcomeAcutalScreen extends StatefulWidget {
  const WelcomeAcutalScreen({super.key});

  @override
  State<WelcomeAcutalScreen> createState() => _WelcomeAcutalScreenState();
}

class _WelcomeAcutalScreenState extends State<WelcomeAcutalScreen> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  late PageController pageController;
  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.none,
          key: const ValueKey('page-view'),
          controller: pageController,
          itemCount: 3,
          onPageChanged: (index) {
            selectedIndex.value = index;
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return WelcomeScreenHolderWidget(
              index: index,
              key: const ValueKey('welcome-screen-holder'),
            );
          },
        ),

        /**
         * FILE_PURPOSE: WELCOME INDICATOR
         */
        WelcomeIndicatorScreen(
          selectedIndex: selectedIndex,
          key: const ValueKey('welcome-indicator'),
        ),

        /**
         * FILE_PURPOSE: WELCOME GET STARTED BUTTON
         */
        WelcomeGetStartedButtonWidget(
          selectedIndex: selectedIndex,
          key: const ValueKey('welcome-get-started-button'),
        ),
      ],
    );
  }
}
