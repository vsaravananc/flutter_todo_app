import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/features/home/widgets/header_widgets/home_category_bottomsheet.dart';
import 'package:todoapp/features/home/widgets/header_widgets/home_choice_chip.dart';

///
///  FILE_PURPOSE: HOME CATEGORY HEADER TO SELECT ANY CATEGORY
///
class HomeCategoryHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const HomeCategoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      key: const ValueKey('home-category-header-category-holder'),
      preferredSize: preferredSize,

      child: SafeArea(
        key: const ValueKey('home-category-header-safe-area'),
        child: Container(
          color: Theme.of(context).colorScheme.surface,
          child: const Row(
            key: ValueKey('home-category-header-row'),
            children: [
              HomeCategoryHeaderChipList(
                key: ValueKey('home-category-header-chip-list'),
              ),
              HomeCategoryHeaderAddIcon(
                key: ValueKey('home-category-header-add-icon'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

///
/// HOME CATEGORY HEADER CHIP LIST PURPOSE: ANIMATE LIST OF CATEGORIES TO SELECT
///

class HomeCategoryHeaderChipList extends StatefulWidget {
  const HomeCategoryHeaderChipList({super.key});

  @override
  State<HomeCategoryHeaderChipList> createState() =>
      _HomeCategoryHeaderChipListState();
}

class _HomeCategoryHeaderChipListState extends State<HomeCategoryHeaderChipList>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  int selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      animationController.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      key: const ValueKey('home-category-header-expanded'),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animationController),
        child: const HomeCategoryHeaderList(
          key: const ValueKey('home-category-header-list'),
        ),
      ),
    );
  }
}

///
/// HOME CATEGORY HEADER LIST PURPOSE: LIST OF CATEGORIES TO SELECT
///

class HomeCategoryHeaderList extends StatelessWidget {
  const HomeCategoryHeaderList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeBlocState>(
      listener: (context, state) {
        if (state is ErrorOnLoadingCategoryState) {
          debugPrint("Error: ${state.message} : ErrorType: ${state.errorType}");
        }
      },
      builder: (context, state) {
        if (state is LoadedCategoryState) {
          return ListView.builder(
            key: const ValueKey('home-category-header-list-view'),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            clipBehavior: Clip.hardEdge,
            addRepaintBoundaries: true,
            itemBuilder: (context, index) {
              CategoryModel categoryModel = state.categories[index];
              return HomeChoiceChip(
                isSelected: state.selectedCategories.id == categoryModel.id,
                categoryModel: categoryModel,
                onSelected: () {
                  context.read<HomeBloc>().add(
                    SelectCategoryEvent(categoryModel: categoryModel),
                  );
                  context.read<TodoBloc>().add(
                    FilterTodoEvent(categoryId: categoryModel.id),
                  );
                },
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: state.categories.length,
          );
        } else {
          return const Text("Oops!");
        }
      },
    );
  }
}

///
/// HOME CATEGORY HEADER ADD ICON PURPOSE: ADD NEW CATEGORYT TO LIST
///

class HomeCategoryHeaderAddIcon extends StatelessWidget {
  const HomeCategoryHeaderAddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          barrierColor: Theme.of(context).colorScheme.surface.withValues(
            alpha: Theme.of(context).brightness == Brightness.dark ? 0.8 : 0.4,
          ),
          context: context,
          builder: (c) {
            return const HomeCategoryBottomsheet();
          },
        );
      },
      icon: const Icon(Icons.add),
      key: const ValueKey('home-category-header-icon-button'),
    );
  }
}
