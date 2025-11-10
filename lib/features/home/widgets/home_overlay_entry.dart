import 'package:flutter/material.dart';
import 'package:todoapp/core/dimensions/dimension.dart';

///
/// FILE_PURPOSE: HOME CATEGORY OVERLAY ENTRY
///

///
/// HOMECATEGORYVERTICALMORE CLASS: THIS CLASS WILL TRIGGER THE OVERLAY ENTRY AND MANAGE IT
///
class HomeCategoryVerticalMore extends StatefulWidget {
  const HomeCategoryVerticalMore({super.key});

  @override
  State<HomeCategoryVerticalMore> createState() =>
      _HomeCategoryVerticalMoreState();
}

class _HomeCategoryVerticalMoreState extends State<HomeCategoryVerticalMore> {
  final LayerLink link = LayerLink();
  final GlobalKey iconKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  // show Overlay Entry
  void _showOverLayEntry() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  // remove Overlay Entry
  void _removeOverLayEntry() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // create Overlay Entry

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox =
        iconKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return OverlayEntry(
      builder: (context) => HomecategoryBottomOverLayEntry(
        size: size,
        link: link,
        onTap: _removeOverLayEntry,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: link,
      child: IconButton(
        onPressed: () {
          (_overlayEntry == null) ? _showOverLayEntry() : _removeOverLayEntry();
        },
        key: iconKey,
        icon: const Icon(
          Icons.more_vert,
          key: ValueKey("home-category-vertical-more-icon"),
        ),
      ),
    );
  }
}

///
/// HOMECATEGORYBOTTOMOVERLAYENTRY CLASS: THIS CLASS DESCRIBE HOW THE OVERLAY ENTRY WILL BE
///

class HomecategoryBottomOverLayEntry extends StatelessWidget {
  final Size size;
  final LayerLink link;
  final VoidCallback? onTap;
  const HomecategoryBottomOverLayEntry({
    super.key,
    required this.size,
    this.onTap,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            offset: Offset(-150 + size.width, -65),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(context).colorScheme.tertiary,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomeCategoryOvelayEnteryMenu(
                    key: const ValueKey(
                      "home-category-overlay-entry-menu-edit",
                    ),
                    onTap: () {
                      debugPrint("Edit clicked");
                      onTap!();
                    },
                    data: "Manage Category",
                    icon: Icons.settings,
                  ),
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
/// HOMECATEGORYOVERLAYENTERYMENU CLASS : THIS CLASS SHOW THE AVALIABLE MENUS OR OPTIONS
///

class HomeCategoryOvelayEnteryMenu extends StatelessWidget {
  final VoidCallback onTap;
  final String data;
  final IconData icon;
  const HomeCategoryOvelayEnteryMenu({
    super.key,
    required this.onTap,
    required this.data,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              key: const ValueKey('home-category-overlay-entry-menu-icon'),
            ),
            const SizedBox(width: Dimension.paddingXSmall),
            Text(
              data,
              style: Theme.of(context).textTheme.bodyMedium,
              key: const ValueKey('home-category-overlay-entry-menu-text '),
            ),
          ],
        ),
      ),
    );
  }
}
