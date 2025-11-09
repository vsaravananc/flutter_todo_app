import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/core/themes/theme.dart';
import 'package:todoapp/database/create_db.dart';
import 'package:todoapp/features/home/bloc/home_bloc_bloc.dart';
import 'package:todoapp/features/home/data/use_case/home_data.dart';
import 'package:todoapp/features/home/domain/home_domain.dart';

Future<void> main() async {
  runApp(await DependencyInjection.injectBloc(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const ValueKey('material-app'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      themeMode: ThemeMode.system,
      routes: Routes.routed,
      title: 'Todo-App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: (s) => Routes.onGenerateRoute(s),
    );
  }
}


class DependencyInjection {
  static Future<Widget> injectBloc(Widget child) async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = await CreateDataBase().database;
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBlocBloc>(
          create: (context) => HomeBlocBloc(
            selecteCategory: SelectCategoryDomain(),
            loadCategory: LoadCategoryDomain(
              loadCategoryData: LoadCategoryData(database: database),
            ),
          ),
        ),
      ],
      child: child,
    );
  }
}
