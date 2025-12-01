import 'package:flutter/material.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/core/extension/category_model_extension.dart';
import 'package:todoapp/features/edit/widget/category/card/category_edit_overlay.dart';

class CategoryEditCard extends StatelessWidget {
  final CategoryModel categoryModel;
  const CategoryEditCard({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey('category_edit_card_${categoryModel.id}'),
      leading: SizedBox(
        height: 10,
        width: 10,
        child: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor,
          key: ValueKey('category_edit_card_avatar_${categoryModel.id}'),
        ),
      ),
      title: Text(
        categoryModel.actuallName,
        key: ValueKey('category_edit_card_title_${categoryModel.id}'),
      ),
      trailing: categoryModel.id == 1
          ? null
          : CategoryEditButton(
              key: const ValueKey("category_edit_button"),
              categoryModel: categoryModel,
            ),
    );
  }
}
