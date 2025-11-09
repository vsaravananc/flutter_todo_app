import 'package:flutter/material.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/features/home/data/model/category_model.dart';

///
///  FILE_PURPOSE: HOME CHOICE CHIP TO SELECT ANY CATEGORY
///

class HomeChoiceChip extends StatelessWidget {
  final CategoryModel categoryModel;
  final bool isSelected;
  final VoidCallback? onSelected;
  const HomeChoiceChip({
    super.key,
    required this.isSelected,
    this.onSelected,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      key: const ValueKey('home-choice-chip-gesture-detector'),
      onTap: onSelected,
      child: AnimatedContainer(
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
        key: const ValueKey('home-choice-chip'),
        margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          key: const ValueKey('home-choice-chip-text'),
          categoryModel.name,
          style: isSelected
              ? Theme.of(
                  context,
                ).textTheme.labelLarge?.copyWith(color: DarkColors.textColor)
              : Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isDark ? LightColors.textColor : DarkColors.textColor,
                ),
        ),
      ),
    );
  }
}
