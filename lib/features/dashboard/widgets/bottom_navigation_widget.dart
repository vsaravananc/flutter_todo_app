import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class BottomNavigationWidget extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const BottomNavigationWidget({super.key, required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 2,
      items: const [
        BottomNavigationBarItem(
          key: ValueKey("bottom_navigation_index"),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
          label: 'Index',
          
        ),
        BottomNavigationBarItem(
          key: ValueKey("bottom_navigation_chart"),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedAnalytics01),
          label: 'Chart',
        ),
      ],
    );
  }
}
