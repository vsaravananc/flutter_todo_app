import 'package:flutter/material.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/core/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key:const ValueKey('material-app'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      themeMode: ThemeMode.system,
      routes: Routes.routed,
      title: 'Todo-App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    );
  }
}
