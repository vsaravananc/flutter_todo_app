import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/core/words/app_words.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_category_select_widget.dart';
import 'package:todoapp/features/home/widgets/floating_widgets/home_date_select_widget.dart';

class HomeFloatingBottomTaskWidget extends StatefulWidget {
  const HomeFloatingBottomTaskWidget({super.key});

  @override
  State<HomeFloatingBottomTaskWidget> createState() =>
      _HomeFloatingBottomTaskWidgetState();
}

class _HomeFloatingBottomTaskWidgetState
    extends State<HomeFloatingBottomTaskWidget> {
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

   void _insertTodo(BuildContext context,int id) {
    if (_textEditingController.text.trim().isEmpty) return;

    int categoryId = (context.read<HomeBloc>().state as LoadedCategoryState)
        .selectedCategories
        .id;

    context.read<TodoBloc>().add(
      AddTodoEvent(
        todo: _textEditingController.text.trim(),
        categoryId: id,
        filterBy: categoryId,
      ),
    );
    _textEditingController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectcategoryCubit, CategoryModel>(
      builder: (_, model) {
        return Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextHolderWidget(
                key: const ValueKey('home-text-holder-widget'),
                id: model.id,
                textEditingController: _textEditingController,
                insertTodo: _insertTodo,
              ),
            ),
            Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HomeCategorySelectWidget(
                  key: ValueKey('home-category-select-widget'),
                ),
                /**
                 * 
                 *  WANT TO WORK :: FEATURE TO IMPLEMENT THIS TO CAPTURE 
                 *  SELECT DATE
                 * 
                 */
                const HomeDateSelectWidget(
                  key: ValueKey('home_date_select_widget'),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                      _insertTodo(context,model.id);
                  },
                  child: HugeIcon(
                    icon: HugeIcons.strokeRoundedSent,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30,
                  ),
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
/// TEXTHOLDERWIDGET CLASS: TO ADD TODOINTODB
///

class TextHolderWidget extends StatelessWidget {
  final int id;
  final TextEditingController textEditingController;
  final void Function(BuildContext context,int id) insertTodo;
  const TextHolderWidget({
    super.key,
    required this.id,
    required this.textEditingController,
    required this.insertTodo,
  });

 

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(18),
      child: TextField(
        controller: textEditingController,
        autofocus: true,
        onSubmitted: (_) => insertTodo(context,id),
        style: const TextStyle(fontSize: 20),
        maxLines: null,
        minLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          filled: true,
          hintText: AppWords.inputNewTaskHere,
          contentPadding: const EdgeInsets.fromLTRB(8, 12, 0, 12),

          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
