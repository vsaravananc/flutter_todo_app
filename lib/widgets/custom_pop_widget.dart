import 'package:flutter/material.dart';

class CustomPopWidget extends StatelessWidget {
  final VoidCallback? onTap;
  const CustomPopWidget({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
      ),
    );
  }
}
