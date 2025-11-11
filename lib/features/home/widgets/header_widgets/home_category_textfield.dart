import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/words/app_words.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';

class HomeCategoryTextfield extends StatefulWidget {
  const HomeCategoryTextfield({super.key});

  @override
  State<HomeCategoryTextfield> createState() => _HomeCategoryTextfieldState();
}

class _HomeCategoryTextfieldState extends State<HomeCategoryTextfield> {
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

  void addCategory() {
    if (_textEditingController.text.trim().isNotEmpty) {
      context.read<HomeBloc>().add(
        AddCategoryEvent(categoryName: _textEditingController.text),
      );
      _textEditingController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        key: const ValueKey('home-category-textfield'),
        controller: _textEditingController,
        autofocus: true,
        onSubmitted: (_) => addCategory(),
        decoration: InputDecoration(
          fillColor: Theme.of(context).colorScheme.surface,
          filled: true,
          hintText: AppWords.categoryHintText,
          suffixIcon: IconButton(
            onPressed: addCategory,
            icon: const Icon(Icons.add),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
