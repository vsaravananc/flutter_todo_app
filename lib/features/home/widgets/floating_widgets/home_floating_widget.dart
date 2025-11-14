import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';

class HomeFloatingWidget extends StatelessWidget {
  const HomeFloatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AvatarGlow(
        glowCount: 1,
        glowColor: Theme.of(context).primaryColor,
        glowRadiusFactor: 0.4,
        repeat: true,
        child: FloatingActionButton(
          splashColor: Theme.of(context).colorScheme.secondary,
          elevation: 2,
          shape: const CircleBorder(),
          onPressed: () {},
          child: Icon(Icons.add, color: LightColors.secondaryTextColor, size: 30),
        ),
      ),
    );
  }
}
