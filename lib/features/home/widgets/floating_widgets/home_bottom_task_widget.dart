import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/words/app_words.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_category_select_widget.dart';

class HomeFloatingBottomTaskWidget extends StatelessWidget {
  const HomeFloatingBottomTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectcategoryCubit, CategoryModel>(
      builder: (_, model) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextHolderWidget(
              key: const ValueKey('home-text-holder-widget'),
              id: model.id,
            ),
            const Spacer(),
            const Row(
              children: [
                HomeCategorySelectWidget(
                  key: ValueKey('home-category-select-widget'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

///
/// TEXTHOLDERWIDGET CLASS: TO ADD TODO INTO DB
///

class TextHolderWidget extends StatefulWidget {
  final int id;
  const TextHolderWidget({super.key, required this.id});

  @override
  State<TextHolderWidget> createState() => _TextHolderWidgetState();
}

class _TextHolderWidgetState extends State<TextHolderWidget> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _insetTodo() {
    if (_textEditingController.text.trim().isEmpty) return;
    int categoryId = (context.read<HomeBloc>().state as LoadedCategoryState).selectedCategories.id;
    context.read<TodoBloc>().add(
      AddTodoEvent(
        todo: _textEditingController.text.trim(),
        categoryId: widget.id,
        filterBy: categoryId,
      ),
    );
    _textEditingController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      autofocus: true,
      onSubmitted: (_) => _insetTodo(),
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        hintText: AppWords.inputNewTaskHere,
        suffixIcon: IconButton(
          onPressed: _insetTodo,
          icon: const Icon(Icons.add),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
