import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/model/todo_model.dart';
import 'package:todoapp/core/services/builder_service.dart';
import 'package:todoapp/widgets/custom_pop_widget.dart';

class VerticalMoreWidget extends StatefulWidget {
  final TodoModel todo;
  const VerticalMoreWidget({super.key, required this.todo});

  @override
  State<VerticalMoreWidget> createState() => _VerticalMoreWidgetState();
}

class _VerticalMoreWidgetState extends State<VerticalMoreWidget> {
  final LayerLink layerLink = LayerLink();
  OverlayEntry? overlayEntry;
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
      builder: (c) => VerticalMoreOptionWidget(
        onTap: _toggle,
        layerLink: layerLink,
        todo: widget.todo,
        key: const ValueKey('vertical_more_option_widget'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: IconButton(
        onPressed: _toggle,
        icon: const Icon(Icons.more_vert_outlined),
      ),
    );
  }
}

///
/// VERTICALMOREWIDGET: IT WILL SHOW THE MORE OPTION VERTICALLY
///

class VerticalMoreOptionWidget extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;
  final LayerLink layerLink;
  const VerticalMoreOptionWidget({
    super.key,
    required this.onTap,
    required this.layerLink,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPopWidget(onTap: onTap),
        Positioned(
          width: 120,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            offset: const Offset(0, 2),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).colorScheme.tertiary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OpptionCardWidget(
                    title: todo.isDone ? "Mark as Undone" : "Mark as Done",
                    onTap: () {
                      int selectedCategoryId =
                          (context.read<HomeBloc>().state
                                  as LoadedCategoryState)
                              .selectedCategories
                              .id;
                      Map<String, dynamic> data = BuilderService()
                          .markIsDone(!todo.isDone)
                          .build;
                      context.read<TodoBloc>().add(
                        UpdateTodoEvent(
                          todo: data,
                          todoId: todo.id,
                          categoryId: selectedCategoryId,
                        ),
                      );
                      onTap();
                    },
                  ),
                  OpptionCardWidget(title: "Delete", onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
/// OpptionCardWidget: IT WILL SHOW THE OPTION CARD
///

class OpptionCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const OpptionCardWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 35,
        child: Center(
          child: Text(title, style: Theme.of(context).textTheme.bodyMedium),
        ),
      ),
    );
  }
}
