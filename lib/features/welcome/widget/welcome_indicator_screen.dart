import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/dimensions/dimension.dart';
import 'package:todoapp/features/welcome/widget/welcome_indicator_dot_widget.dart';

class WelcomeIndicatorScreen extends StatelessWidget {
  final ValueListenable<int> selectedIndex;
  const WelcomeIndicatorScreen({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      key: const ValueKey('value-listenable-builder-indicator'),
      valueListenable: selectedIndex,
      builder: (context, value, child) {
        return Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Column(
            key: const ValueKey('welcome-indicator-column'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WelcomeIndicatorDotWidget(
                value: value == 0,
                key: const ValueKey('welcome-indicator-dot-0'),
              ),
              const SizedBox(height: Dimension.paddingSmall),
              WelcomeIndicatorDotWidget(
                value: value == 1,
                key: const ValueKey('welcome-indicator-dot-1'),
              ),
              const SizedBox(height: Dimension.paddingSmall),
              WelcomeIndicatorDotWidget(
                value: value == 2,
                key: const ValueKey('welcome-indicator-dot-2'),
              ),
            ],
          ),
        );
      },
    );
  }
}
