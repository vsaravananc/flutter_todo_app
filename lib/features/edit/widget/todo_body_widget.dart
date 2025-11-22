import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/controller/todo_edit_logic/controller/todo_edit_controller.dart';
import 'package:todoapp/core/extension/category_model_extension.dart';
import 'package:todoapp/core/themes/colors.dart';
import 'package:todoapp/widgets/custom_pop_widget.dart';

class TodoBodyWidget extends StatefulWidget {
  final TodoModel todoModel;
  const TodoBodyWidget({super.key, required this.todoModel});

  @override
  State<TodoBodyWidget> createState() => _TodoBodyWidgetState();
}

class _TodoBodyWidgetState extends State<TodoBodyWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController(
      text: widget.todoModel.title,
    );
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropDownWidget(todoModel: widget.todoModel),
          const SizedBox(height: 10),
          CustomTextWidgetHolder(
            todoModel: widget.todoModel,
            controller: _textEditingController,
          ),
        ],
      ),
    );
  }
}

///
/// CUSTOMDROPDOWNWIDGET CLASS: it is used to show and select the category on dropdown
///

class CustomDropDownWidget extends StatefulWidget {
  final TodoModel todoModel;
  const CustomDropDownWidget({super.key, required this.todoModel});

  @override
  State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
}

class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;

  void _toggle() {
    if (overlayEntry == null) {
      overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(overlayEntry!);
    } else {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (c) => CustomDropDownOptionWidget(
        layerLink: layerLink,
        toggle: _toggle,
        todoModel: widget.todoModel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: CompositedTransformTarget(
        link: layerLink,
        child: const CustomDropDownSelectedWidget(),
      ),
    );
  }
}

///
/// CUSTOMDROPDOWNSELECTEDWIDGET CLASS: IT IS USED TO SHOW THE SELECTED OPTION FROM DROPDOWN
///

class CustomDropDownSelectedWidget extends StatelessWidget {
  const CustomDropDownSelectedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 5, top: 3, bottom: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).colorScheme.onSurface,
          width: 0.6,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextSelecterWidgetHolder(),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}

///
/// CUSTOMTEXTSELECTERWIDGETHOLDER CLASS: IT IS USED TO SHOW THE TEXTFIELD
///

class CustomTextSelecterWidgetHolder extends StatelessWidget {
  const CustomTextSelecterWidgetHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: const ValueKey('home-choice-chip-text'),
      constraints: const BoxConstraints(minWidth: 15, maxWidth: 95),
      child: BlocBuilder<SelectcategoryCubit, CategoryModel>(
        builder: (c, state) {
          return Text(
            state.actuallName,
            style: Theme.of(context).textTheme.labelLarge,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          );
        },
      ),
    );
  }
}

///
/// CUSTOMDROPDOWNOPTIONWIDGET CLASS: IT PROVIDE THE OPTIONS TO SELECT FROM DROPDOWN
///

class CustomDropDownOptionWidget extends StatelessWidget {
  final LayerLink layerLink;
  final VoidCallback toggle;
  final TodoModel todoModel;
  const CustomDropDownOptionWidget({
    super.key,
    required this.layerLink,
    required this.toggle,
    required this.todoModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPopWidget(onTap: toggle),
        Positioned(
          width: 140,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 10),
            targetAnchor: Alignment.bottomLeft,
            followerAnchor: Alignment.topLeft,
            child: DropDownOptionVisible(todoModel: todoModel, toggle: toggle),
          ),
        ),
      ],
    );
  }
}

///
/// DROPDOWNOPTIONVISIBLE CLASS: IT SHOW THE AVALIABLE OPTIONS
///

class DropDownOptionVisible extends StatelessWidget {
  final TodoModel todoModel;
  final VoidCallback toggle;
  const DropDownOptionVisible({
    super.key,
    required this.todoModel,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(6),
      color: Theme.of(context).colorScheme.tertiary,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 175),
        child: BlocBuilder<HomeBloc, HomeBlocState>(
          builder: (c, state) {
            if (state is LoadedCategoryState) {
              return ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                key: const ValueKey('dropdown-category-listview'),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  return DropDownWidgetCard(
                    onTap: () {
                      context.read<SelectcategoryCubit>().selectCategory(
                        category,
                      );
                      TodoEditController.instance
                          ?.updateTodo(
                            id: todoModel.id.toString(),
                            key: 'categoryId',
                            value: context
                                .read<SelectcategoryCubit>()
                                .id()
                                .toString(),
                            context: context,
                          )
                          .then((_) => toggle());
                    },
                    title: category.actuallName,
                  );
                },
              );
            } else {
              return const Text("No Categories");
            }
          },
        ),
      ),
    );
  }
}

///
/// DROPDOWNWIDGETCARD CLASS: IT IS USED TO SHOW THE OPTIONS
///

class DropDownWidgetCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const DropDownWidgetCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 35,
        key: ValueKey('dropdown-category-item-$title'),
        child: Align(
          alignment: AlignmentGeometry.centerLeft,
          child: Text(title, style: Theme.of(context).textTheme.labelLarge),
        ),
      ),
    );
  }
}

///
/// CUSTOMTEXTWIDGETHOLDER CLASS: IT IS USED TO SHOW THE TEXT AND EDIT THE TEXT
///

class CustomTextWidgetHolder extends StatelessWidget {
  final TodoModel todoModel;
  final TextEditingController controller;
  const CustomTextWidgetHolder({
    super.key,
    required this.todoModel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      onChanged: (task) async {
        await TodoEditController.instance?.updateTodo(
          id: todoModel.id.toString(),
          key: 'title',
          value: controller.text,
          context: context,
        );
      },
      key: const ValueKey('todo-body-widget-textfield-title'),
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: todoModel.title,
        hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: isDark ? DarkColors.hintColor : LightColors.hintColor,
        ),
      ),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}
