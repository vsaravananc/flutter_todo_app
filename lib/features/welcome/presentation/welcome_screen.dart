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

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    return Scaffold(
      key: const ValueKey('welcome-screen'),
      body: Stack(
        children: [
          PageView.builder(
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
          WelcomeIndicatorScreen(
            selectedIndex: selectedIndex,
            key: const ValueKey('welcome-indicator'),
          ),
          WelcomeGetStartedButtonWidget(
            selectedIndex: selectedIndex,
            key: const ValueKey('welcome-get-started-button'),
          ),
        ],
      ),
    );
  }
}
