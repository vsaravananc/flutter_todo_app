import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_slidable_widget.dart';
import 'package:todoapp/features/home/widgets/body_widgets/home_todo_card.dart';

class HomeTodoListWidget extends StatefulWidget {
  const HomeTodoListWidget({super.key});

  @override
  State<HomeTodoListWidget> createState() => _HomeTodoListWidgetState();
}

class _HomeTodoListWidgetState extends State<HomeTodoListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  void _initAnimation() {
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
        child: const SlidableTapOutSideWidget(
          key: const ValueKey('slidable-tap-outside-widget'),
        ),
      ),
    );
  }
}

///
/// SLIDABLETAPOUTSIDEWIDGET CLASS: IT WILL ALOW THE USER TO TAP ANY WERE TO CLOSE THE CURRENT SLIDABLE OPTIONS
///

class SlidableTapOutSideWidget extends StatelessWidget {
  const SlidableTapOutSideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SlidableAutoCloseBehavior(
      closeWhenOpened: true,
      child: ReOrderableStateChangerWidget(
        key: const ValueKey('reorderable-state-changer-widget'),
      ),
    );
  }
}

///
/// REORDERABLESTATECHANGER CLASS: IT REPLACE THE LIST BY USER PREFERENCES
///

class ReOrderableStateChangerWidget extends StatelessWidget {
  const ReOrderableStateChangerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      footer: const SizedBox(height: 10),
      clipBehavior: Clip.none,
      key: const ValueKey('reorderable-listview'),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemCount: 20,
      onReorder: (oldIndex, newIndex) {},
      proxyDecorator: (child, index, animation) {
        return ProxyDecorateWidget(index: index);
      },
      buildDefaultDragHandles: false,
      itemBuilder: (context, index) {
        return HomeSlidableWidget(index: index, key: ValueKey(index));
      },
    );
  }
}


///
/// PROXYDECORATEWIDGET CLASS: IT DECORATE EACH CARD WHEN THE USER DRAG THE CARD
///

class ProxyDecorateWidget extends StatelessWidget {
  final int index;
  const ProxyDecorateWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Material(
      key: const ValueKey('proxy-decorate-widget'),
      color: Colors.transparent,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(6),
        side: const BorderSide(color: Colors.white12, width: 1.3),
      ),
      child: HomeTodoCardWidget(index: index),
    );
  }
}
