import 'package:flutter/material.dart';
import 'package:todoapp/core/dimensions/dimension.dart';
import 'package:todoapp/core/images/images.dart';
import 'package:todoapp/core/words/app_words.dart';

class WelcomeScreenHolderWidget extends StatelessWidget {
  final int index;
  const WelcomeScreenHolderWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimension.paddingXLNormal,
      ),
      child: Column(
        key: const ValueKey('welcome-column'),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Images.wlecome[index],
            height: 180,
            width: 180,
            key: const ValueKey('welcome-image'),
          ),
          Column(
            key: const ValueKey('welcome-column-text'),
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppWords.welcomeTitle[index],
                style: Theme.of(context).textTheme.headlineLarge,
                key: const ValueKey('welcome-title'),
              ),
              const SizedBox(height: Dimension.paddingXLSmall),
              Text(
                AppWords.welcomeDescription[index],
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 3,
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                key: const ValueKey('welcome-description'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
