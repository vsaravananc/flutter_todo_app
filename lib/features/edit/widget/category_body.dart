import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/features/edit/widget/category_edit_card.dart';

class CategoryEditBody extends StatelessWidget {
  const CategoryEditBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeBlocState>(
      builder: (context, state) {
        if (state is LoadedCategoryState) {
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              key: const ValueKey('home-category-header-list-view'),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return CategoryEditCard(
                  key: ValueKey('category_edit_card_$index'),
                  categoryModel:state.categories[index],
                );
              },
              scrollDirection: Axis.vertical,
              itemCount: state.categories.length,
            ),
          );
        } else {
          return const Text("No Category Found!");
        }
      },
    );
  }
}
