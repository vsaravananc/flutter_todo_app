import 'package:flutter/material.dart';
import 'package:todoapp/core/dimensions/dimension.dart';

class WelcomeIndicatorDotWidget extends StatelessWidget {
  final bool value;
  const WelcomeIndicatorDotWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutSine,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Dimension.paddingXLSmall),
      ),
      height: value ? 20 : 5,
      width: 5,
    );
  }
}
