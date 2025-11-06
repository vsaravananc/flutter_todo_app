import 'package:flutter/material.dart';
import 'package:todoapp/core/words/app_words.dart';

///
///  FILE_PURPOSE: SPLASH ANIMATION
///

class SplashAnimationAppWidget extends StatelessWidget {
  final ValueNotifier<bool> isDark;

  const SplashAnimationAppWidget({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      key: const ValueKey('value-listenable-builder'),
      valueListenable: isDark,
      builder: (context, value, child) {
        return AnimatedSwitcher(
          key: const ValueKey('animated-switcher'),
          duration: const Duration(milliseconds: 280),
          switchInCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            final position = Tween<Offset>(
              begin: const Offset(-0.3, 0),
              end: Offset.zero,
            ).animate(animation);

            return AnimatedSize(
              key: const ValueKey('animated-size'),
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeIn,
              child: FadeTransition(
                key: const ValueKey('fade-transition'),
                opacity: animation,
                child: SlideTransition(
                  key: const ValueKey('slide-transition'),
                  position: position,
                  child: child,
                ),
              ),
            );
          },
          child: value
              ? Text(
                  AppWords.appName,
                  key: const ValueKey('app-name'),
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall,
                )
              : const SizedBox.shrink(key: ValueKey('sized-box')),
        );
      },
    );
  }
}
