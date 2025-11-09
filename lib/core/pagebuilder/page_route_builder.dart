import 'package:flutter/widgets.dart';

///
/// FILE_PURPOSE: ROUTE BUILDER
///

class CustomRouteBuilder {
  static PageRouteBuilder simplePageRouteBuilder(Widget nextScreen) {
    return PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, a, sa) => nextScreen,
      transitionsBuilder: (_, a, sa, child) => child,
      transitionDuration: const Duration(milliseconds: 1800),
    );
  }
}
