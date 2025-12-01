import 'package:flutter/material.dart';

class CategoryEditHeader extends StatelessWidget {
  const CategoryEditHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              key: ValueKey('category_edit_header_icon'),
            ),
            key: const ValueKey('category_edit_header_icon_button'),
          ),
          const Spacer(key: ValueKey('category_edit_header_spacer')),
          Text(
            "Manage Category",
            key: const ValueKey('category_edit_header_text'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Spacer(key: ValueKey('category_edit_header_spacer-2'), flex: 2),
        ],
      ),
    );
  }
}

class CategoryTitleHolder extends StatelessWidget {
  const CategoryTitleHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('category_title_holder_container'),
      margin: const EdgeInsets.only(bottom: 10, top: 5),
      width: double.infinity,
      height: 20,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
      child: Center(
        key: const ValueKey('category_title_holder'),
        child: Text(
          ' categories displayed on the homepage',
          style: Theme.of(context).textTheme.bodySmall,
          key: const ValueKey('category_title_holder_text'),
        ),
      ),
    );
  }
}
