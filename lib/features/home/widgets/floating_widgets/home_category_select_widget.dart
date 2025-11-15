import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/core/extension/category_model_extension.dart';
import 'package:todoapp/core/themes/colors.dart';

class HomeCategorySelectWidget extends StatefulWidget {
  const HomeCategorySelectWidget({super.key});

  @override
  State<HomeCategorySelectWidget> createState() =>
      _HomeCategorySelectWidgetState();
}

class _HomeCategorySelectWidgetState extends State<HomeCategorySelectWidget> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  void _toggle() {
    if (overlayEntry == null) {
      overlayEntry = _createOveLayEntry();
      Overlay.of(context).insert(overlayEntry!);
    } else {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  OverlayEntry _createOveLayEntry() {
    return OverlayEntry(
      builder: (_) => OverLayFlowerWidget(link: layerLink, onTap: _toggle),
    );
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 120, minWidth: 60),
        child: BlocBuilder<SelectcategoryCubit, CategoryModel>(
          builder: (_, model) {
            return Material(
              key: const ValueKey('home-category-select-widget'),
              borderRadius: BorderRadius.circular(50),
              color: model.isAll
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).primaryColor,
              child: InkWell(
                key: const ValueKey('home-category-select-widget-inkwell'),
                onTap: _toggle,
                splashColor: Theme.of(context).primaryColor,
                splashFactory: InkSplash.splashFactory,
                borderRadius: BorderRadius.circular(50),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 6,
                  ),
                  child: Text(
                    model.actuallName,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: DarkColors.textColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

///
/// OVERLAYFLOWERWIDGET CLASS: THIS CLASS FLOW THE TARGET WIDGET
///

class OverLayFlowerWidget extends StatelessWidget {
  final LayerLink link;
  final VoidCallback? onTap;
  const OverLayFlowerWidget({super.key, required this.link, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTap,
          ),
        ),
        Positioned(
          width: 170,
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: const Offset(1, -5),
            followerAnchor: Alignment.bottomLeft,
            targetAnchor: Alignment.topLeft,
            child: SelectCategoryWidget(
              key: const ValueKey('select-category-widget'),
              onTap: onTap!,
            ),
          ),
        ),
      ],
    );
  }
}

///
/// SELECTCATEGORYWIDGET CLASS: THIS CLASS WILL HELP THE USER TO SELECT A CATEGORY
///

class SelectCategoryWidget extends StatelessWidget {
  final VoidCallback onTap;
  const SelectCategoryWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.tertiary,
      borderRadius: BorderRadius.circular(8),
      elevation: 1,
      child: Container(
        width: 170,
        constraints: const BoxConstraints(maxHeight: 200, minHeight: 80),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (context, state) {
            if (state is LoadedCategoryState) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 4),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (c, i) {
                  CategoryModel categoryModel = state.categories[i];
                  return SelectCateGoryCardWidget(
                    categoryModel: categoryModel,
                    onTap: onTap,
                  );
                },
                itemCount: state.categories.length,
                shrinkWrap: true,
                addRepaintBoundaries: true,
              );
            } else {
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text("No Category"), Text("Add Category")],
              );
            }
          },
        ),
      ),
    );
  }
}

///
/// SELECTCATEGORYCARDWIDGET CLASS : IT HOLD TH CATEGORY NAME
///

class SelectCateGoryCardWidget extends StatelessWidget {
  final CategoryModel categoryModel;
  final VoidCallback onTap;
  const SelectCateGoryCardWidget({
    super.key,
    required this.categoryModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<SelectcategoryCubit>().selectCategory(categoryModel);
        onTap();
      },
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            categoryModel.actuallName,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
