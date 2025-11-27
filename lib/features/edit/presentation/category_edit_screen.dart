import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/core/extension/category_model_extension.dart';

class CategoryEditScreen extends StatelessWidget {
  const CategoryEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.tertiary,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 15),
            child: Text(
              "Manage Category",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            height: 30,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Center(
              child: Text(
                ' categories displayed on the homepage',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          BlocBuilder<HomeBloc, HomeBlocState>(
            builder: (context, state) {
              if (state is LoadedCategoryState) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    key: const ValueKey('home-category-header-list-view'),
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      CategoryModel categoryModel = state.categories[index];
                      return ListTile(
                        leading: SizedBox(
                          height: 10,
                          width: 10,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                        title: Text(categoryModel.actuallName),
                        trailing: const Icon(Icons.more_vert_sharp),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: state.categories.length,
                  ),
                );
              } else {
                return const Text("Oops!");
              }
            },
          ),
        ],
      ),
    );
  }
}
