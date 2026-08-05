import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todoapp/core/services/app_show_case.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_floating_widget.dart';

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

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: Platform.isIOS ? 0 : 8,
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          final double width = constraint.maxWidth * 0.32;
          return Row(
            children: [
              Expanded(
                flex: 4,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    if (details.delta.dx > 1) {
                      onTap(1);
                    } else if (details.delta.dx < -1) {
                      onTap(0);
                    }
                  },
                  child: Container(
                    height: kToolbarHeight + (Platform.isIOS ? 8 : 10),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(9e3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonIcon(
                          isSelected: currentIndex == 0,
                          width: width,
                          child: IconButton(
                            icon: Column(
                              children: [
                                const HugeIcon(
                                  icon: HugeIcons.strokeRoundedHome01,
                                ),
                                Text(
                                  "Home",
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        color: currentIndex == 0
                                            ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                            : Theme.of(
                                                context,
                                              ).textTheme.labelSmall?.color,
                                      ),
                                ),
                              ],
                            ),
                            onPressed: () => onTap(0),
                            color: currentIndex == 0
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).iconTheme.color,
                          ),
                        ),
                        CustomButtonIcon(
                          isSelected: currentIndex == 1,
                          width: width,
                          child: Showcase(
                            key: AppShowCase.analystic,
                            title: "Track Your Task Progress",
                            description:
                                "View charts and insights of your todo list to understand completed and pending tasks easily.",
                            child: IconButton(
                              icon: Column(
                                children: [
                                  const HugeIcon(
                                    icon: HugeIcons.strokeRoundedAnalytics01,
                                  ),
                                  Text(
                                    "Analytics",
                                    style: Theme.of(context).textTheme.labelSmall
                                        ?.copyWith(
                                          color: currentIndex == 1
                                              ? Theme.of(
                                                  context,
                                                ).colorScheme.primary
                                              : Theme.of(
                                                  context,
                                                ).textTheme.labelSmall?.color,
                                        ),
                                  ),
                                ],
                              ),
                              onPressed: () => onTap(1),
                              color: currentIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).iconTheme.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const HomeFloatingWidget(),
            ],
          );
        },
      ),
    );
  }
}

class CustomButtonIcon extends StatelessWidget {
  final bool isSelected;
  final double width;
  final Widget child;
  const CustomButtonIcon({
    super.key,
    required this.isSelected,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + (Platform.isIOS ? 0 : 2),
      width: width,
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(9e3),
      ),
      child: child,
    );
  }
}
