import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todoapp/core/services/app_show_case.dart';

class BottomNavigationWidget extends StatelessWidget {
  final Function(int) onTap;
  final int currentIndex;
  const BottomNavigationWidget({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      elevation: 2,
      items: [
        const BottomNavigationBarItem(
          key: ValueKey("bottom_navigation_index"),
          icon: HugeIcon(icon: HugeIcons.strokeRoundedHome01),
          label: 'Index',
        ),
        BottomNavigationBarItem(
          key: const ValueKey("bottom_navigation_chart"),
          icon: Showcase(
            key: AppShowCase.analystic,
            title: "Track Your Task Progress",
            description:
                "View charts and insights of your todo list to understand completed and pending tasks easily.",
            child: const HugeIcon(icon: HugeIcons.strokeRoundedAnalytics01),
          ),
          label: 'Chart',
        ),
      ],
    );
  }
}
