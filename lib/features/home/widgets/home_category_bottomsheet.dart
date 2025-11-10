import 'package:flutter/material.dart';
import 'package:todoapp/features/home/widgets/home_category_textfield.dart';
import 'package:todoapp/features/home/widgets/home_overlay_entry.dart';

///
///  FILE_PURPOSE: HOME CATEGORY BOTTOM SHEET TO GET NEW CATEGORY
///

/// HOMECATEGORYBOTTOMSHEET CLASS: THIS CLASS WILL ALLOW THE USER TO ADD NEW CATEGORYES

class HomeCategoryBottomsheet extends StatelessWidget {
  const HomeCategoryBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('home-category-bottomsheet-container'),
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: const Row(
        children: [
          HomeCategoryTextfield(),
          HomeCategoryVerticalMore(
            key: ValueKey('home-category-bottomsheet-kick-start-overlay-entry'),
          ),
        ],
      ),
    );
  }
}
