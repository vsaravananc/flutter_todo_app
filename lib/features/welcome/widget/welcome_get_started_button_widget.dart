import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';

class WelcomeGetStartedButtonWidget extends StatelessWidget {
  final ValueListenable<int> selectedIndex;
  const WelcomeGetStartedButtonWidget({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      key: const ValueKey('value-listenable-builder-get-started-button'),
      valueListenable: selectedIndex,
      builder: (context, value, _) {
        return Positioned(
          right: 10,
          top: 0,
          bottom: 0,
          child: Column(
            key: const ValueKey('welcome-get-started-button-column'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                key: const ValueKey('welcome-get-started-button'),
                onPressed: value == 2
                    ? () {
                        debugPrint("Get Started Button Clicked");
                      }
                    : () {},
                icon: Icon(
                  key: const ValueKey('welcome-get-started-button-icon'),
                  Icons.arrow_forward,
                  color: value == 2
                      ? Theme.of(context).brightness == Brightness.dark
                            ? DarkColors.textColor
                            : LightColors.textColor
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
