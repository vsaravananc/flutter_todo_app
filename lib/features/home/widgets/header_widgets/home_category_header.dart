import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/services/app_show_case.dart';
import 'package:todoapp/core/services/happtic_effect.dart';
import 'package:todoapp/features/home/widgets/header_widgets/home_category_bottomsheet.dart';
import 'package:todoapp/features/home/widgets/header_widgets/home_choice_chip.dart';

///
///  FILE_PURPOSE: HOME CATEGORY HEADER TO SELECT ANY CATEGORY
///
class PrivateCategory extends StatelessWidget {
  const PrivateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        spacing: 8,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 6,right: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "PRIVATE",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const PrivateCategoryAddIcon(),
              ],
            ),
          ),
          AnimatedContainer(
            duration: 250.ms,
            padding: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
              color: Theme.of(context).cardColor,
            ),
            child: const PrivateCategoryList(),
          ),
        ],
      ),
    );
  }

}

///
/// HOME CATEGORY HEADER CHIP LIST PURPOSE: ANIMATE LIST OF CATEGORIES TO SELECT
///
///
///. [ NOTE: (PrivateCategoryChipList) HAVE NOT USED IN THE APP, BUT IT IS A GOOD PRACTICE TO ANIMATE THE LIST OF CATEGORIES TO SELECT ]

class PrivateCategoryChipList extends StatefulWidget {
  const PrivateCategoryChipList({super.key});

  @override
  State<PrivateCategoryChipList> createState() =>
      _PrivateCategoryChipListState();
}

class _PrivateCategoryChipListState extends State<PrivateCategoryChipList>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  int selectedIndex = 0;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    animationController.forward();

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
          begin: const Offset(0.5, 0),
          end: Offset.zero,
        ).animate(animationController),
        child: Showcase(
          key: AppShowCase.appBar,
          descriptionTextAlign: TextAlign.center,
          title: "Organize Your Tasks Easily",
          description:
              "View categories designed to keep your tasks clean, sorted, and clutter-free.",

          child: const PrivateCategoryList(
            key: const ValueKey('home-category-header-list'),
          ),
        ),
      ),
    );
  }
}

///
/// HOME CATEGORY HEADER LIST PURPOSE: LIST OF CATEGORIES TO SELECT
///

class PrivateCategoryList extends StatelessWidget {
  const PrivateCategoryList({super.key});

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
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Row(
                children: [
                  const Expanded(child: SizedBox(width: 1)),
                  Expanded(
                    flex: 6,
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 0.2,
                      height: 1,
                    ),
                  ),
                ],
              );
            },
            padding: const EdgeInsets.all(0),
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            addAutomaticKeepAlives: true,
            clipBehavior: Clip.hardEdge,
            addRepaintBoundaries: true,
            itemBuilder: (context, index) {
              CategoryModel categoryModel = state.categories[index];
              return HomeChoiceChip(
                key: ValueKey('home-choice-chip-${categoryModel.id}'),
                isSelected: state.selectedCategories.id == categoryModel.id,
                categoryModel: categoryModel,
                onSelected: () {
                  context.read<HomeBloc>().add(
                    SelectCategoryEvent(categoryModel: categoryModel),
                  );
                  context.read<SelectcategoryCubit>().selectCategory(
                    categoryModel,
                  );
                  context.read<TodoBloc>().add(
                    FilterTodoEvent(categoryId: categoryModel.id),
                  );
                },
              );
            },
            scrollDirection: Axis.vertical,
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

class PrivateCategoryAddIcon extends StatelessWidget {
  const PrivateCategoryAddIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: AppShowCase.addCategory,
      title: "Add New Category",
      descriptionTextAlign: TextAlign.center,
      description:
          "Create your own category to organize tasks the way you like.",
      child: GestureDetector(
        onTap: () {
           HappticEffect.selectionEffect();
          triggerBottomSheet(context);
        },
        key: const ValueKey('home-category-header-icon-button'),
        child: const SizedBox(
          height: 30,
          width: 30,
          child: Padding(
            padding: EdgeInsets.all(3),
            child:  HugeIcon(icon: HugeIcons.strokeRoundedAdd01),
          ),
        ),
      ),
    );
  }

  void triggerBottomSheet(BuildContext context) {
    if (Platform.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (_) => const HomeCategoryBottomsheet(
          key: const ValueKey("home_category_bottomsheet-android11"),
        ),
      );
    } else {
      showCupertinoSheet(
        context: context,
        scrollableBuilder: (_, s) => const Wrap(
          runAlignment: WrapAlignment.end,
          children: [
            HomeCategoryBottomsheet(
              key: const ValueKey("home_category_bottomsheet"),
            ),
          ],
        ),
      );
    }
  }
}
