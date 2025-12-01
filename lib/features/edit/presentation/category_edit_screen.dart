import 'package:flutter/material.dart';
import 'package:todoapp/features/edit/widget/category/category_body.dart';
import 'package:todoapp/features/edit/widget/category/category_edit_header.dart';

class CategoryEditScreen extends StatelessWidget {
  const CategoryEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: const Column(
        children: [
          CategoryEditHeader(key: ValueKey('category_edit_screen_header')),
          CategoryTitleHolder(
            key: ValueKey('category_edit_screen_title_holder'),
          ),
          CategoryEditBody(key: ValueKey('category_edit_screen_body')),
        ],
      ),
    );
  }
}
