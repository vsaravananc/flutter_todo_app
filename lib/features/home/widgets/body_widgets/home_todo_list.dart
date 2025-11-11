import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeTodoListWidget extends StatefulWidget {
  const HomeTodoListWidget({super.key});

  @override
  State<HomeTodoListWidget> createState() => _HomeTodoListWidgetState();
}

class _HomeTodoListWidgetState extends State<HomeTodoListWidget>
    with SingleTickerProviderStateMixin {
  final List<String> items = List.generate(10, (i) => 'Data $i');
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 400), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SlidableAutoCloseBehavior(
          closeWhenOpened: true,
          child: ReorderableListView.builder(
            key: const ValueKey('reorderable-listview'),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: items.length,
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = items.removeAt(oldIndex);
                items.insert(newIndex, item);
              });
            },
            proxyDecorator: (child, index, animation) {
              final item = items[index];
              return Material(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.more_vert_outlined),
                    ),
                  ),
                ),
              );
            },
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                key: ValueKey(index),
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Slidable(
                  key: ValueKey(item),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: 0.4,
                    children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                        onPressed: (_) => debugPrint('Edit $item'),
                        backgroundColor: Colors.blue,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(8),
                        ),
                        onPressed: (_) {
                          setState(() => items.removeAt(index));
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: const Radio(value: false),
                      title: Text(
                        item,
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.more_vert_outlined),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
