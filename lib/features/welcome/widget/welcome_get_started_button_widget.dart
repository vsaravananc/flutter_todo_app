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
        bool isEnd = value == 2;
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 550),
          curve: Curves.ease,
          right: isEnd ? 10 : -40,
          top: 0,
          bottom: 0,
          child: Column(
            key: const ValueKey('welcome-get-started-button-column'),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedOpacity(
                key: const ValueKey('welcome-get-started-button-opacity'),
                duration: const Duration(milliseconds: 1250),
                opacity: isEnd ? 1 : 0,
                curve: Curves.ease,
                child: IconButton(
                  key: const ValueKey('welcome-get-started-button'),
                  onPressed: isEnd
                      ? () {
                          debugPrint("Get Started Button Clicked");
                        }
                      : () {},
                  icon: Icon(
                    key: const ValueKey('welcome-get-started-button-icon'),
                    Icons.arrow_forward,
                    color: isEnd
                        ? Theme.of(context).brightness == Brightness.dark
                              ? DarkColors.textColor
                              : LightColors.textColor
                        : Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
