import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';

class CategoryEditButton extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryEditButton({super.key, required this.categoryModel});

  @override
  State<CategoryEditButton> createState() => _CategoryEditButtonState();
}

class _CategoryEditButtonState extends State<CategoryEditButton> {
  OverlayEntry? overlayEntry;
  LayerLink layerLink = LayerLink();

  void _toggle() {
    if (overlayEntry == null) {
      overlayEntry = _createOverlayEntery();
      Overlay.of(context).insert(overlayEntry!);
    } else {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntery() {
    return OverlayEntry(
      builder: (_) => CategoryEditOverlayFlower(
        layerLink: layerLink,
        toggle: _toggle,
        categoryModel: widget.categoryModel,
        key: const ValueKey("custome_overlayer_enter_category-edit"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: IconButton(
        onPressed: _toggle,
        icon: const Icon(
          Icons.more_vert,
          key: ValueKey('category_edit_button_icon'),
        ),
      ),
    );
  }
}

class CategoryEditOverlayFlower extends StatelessWidget {
  final LayerLink layerLink;
  final VoidCallback toggle;
  final CategoryModel categoryModel;
  const CategoryEditOverlayFlower({
    super.key,
    required this.layerLink,
    required this.toggle,
    required this.categoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: toggle,
            behavior: HitTestBehavior.translucent,
          ),
        ),
        Positioned(
          width: 80,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.tertiary,
              child: Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          toggle();
                          showDialog(
                            
                            context: context,
                            builder: (_) =>
                                CategoryEditTitle(categoryModel: categoryModel),
                          );
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(child: const Text('Edit')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<HomeBloc>().add(
                            DeleteCategoryEvent(categoryId: categoryModel.id),
                          );
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          child: Center(child: const Text('Delete')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryEditTitle extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryEditTitle({super.key, required this.categoryModel});

  @override
  State<CategoryEditTitle> createState() => _CategoryEditTitleState();
}

class _CategoryEditTitleState extends State<CategoryEditTitle> {
  late TextEditingController controller;
  @override
  void initState() {
    controller = TextEditingController(text: widget.categoryModel.name);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            TextField(
              key: const ValueKey('category-edittitle-widget'),
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                filled: true,
                hintText: widget.categoryModel.name,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  key: const ValueKey('category-edit-title-button'),
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const SizedBox(width: 10),
                TextButton(
                  style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  ),
                  key: const ValueKey('category-edit-title-button-2'),
                  child: Text(
                    'Save',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    context.read<HomeBloc>().add(
                      UpdateCategoryEvent(
                        categoryId: widget.categoryModel.id,
                        categoryName: controller.text.trim(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
