import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/data.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/domain.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/use_case/todo_data.dart';
import 'package:todoapp/controller/todo_controller/domain/todo_domain.dart';
import 'package:todoapp/controller/todo_edit_logic/controller/todo_edit_controller.dart';
import 'package:todoapp/controller/todo_edit_logic/data/todo_edit_data.dart';
import 'package:todoapp/controller/todo_edit_logic/domain/todo_edit_domain.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/core/themes/theme.dart';
import 'package:todoapp/database/create_db.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/use_case/home_data.dart';
import 'package:todoapp/controller/category_controller/domain/home_domain.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://ff712c9132906bd2a58b5f5acbb456e1@o4510412501876736.ingest.de.sentry.io/4510412506792016';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () async => runApp(
      SentryWidget(child: await DependencyInjection.injectBloc(const MyApp())),
    ),
  );
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
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      debugPrint("Errors: ${details.exception}");
    };
    final database = await CreateDataBase().database;
    LoadCategoryDomain loadCategoryDomain = LoadCategoryDomain(
      loadCategoryData: LoadCategoryData(database: database),
    );

    final SelectCategoryReadDomain fetchCategory = SelectCategoryReadDomain(
      fetchData: SelectCategoryReadData(database: database),
    );

    TodoEditController.init(
      todoEditDomain: TodoEditDomain(
        todoEditData: TodoEditData(database: database),
      ),
    );

    FetchAllTodoData fetchAllTodoData = FetchAllTodoData(database: database);
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            selecteCategory: SelectCategoryDomain(),
            loadCategory: loadCategoryDomain,
            addCategory: AddCategoryDomain(
              insertData: AddCategoryData(database: database),
              loadCategory: loadCategoryDomain,
            ),
          ),
        ),
        BlocProvider<TodoBloc>(
          create: (_) => TodoBloc(
            readAllListOfTodos: FetchAllTodoDomain(
              fetchAllTodo: fetchAllTodoData,
            ),

            updateTodo: UpdateTodoDoDomain(
              updateTodo: UpdateTodoData(database: database),
            ),

            fetchTodoList: FetchFilterTodoDomain(
              fetchAllTodo: fetchAllTodoData,
            ),

            insertTodo: AddTodoDomain(
              insertTodo: AddTodoData(database: database),
            ),

            deleteTodoDomain: DeleteTodoDomain(
              deleteTodo: DeleteTodoData(database: database),
            ),

            reOrderTodoDomain: ReOrderTodoDomain(
              reOrder: ReOrderTodoData(database: database),
            ),
          ),
        ),
        BlocProvider<SelectcategoryCubit>(
          create: (_) => SelectcategoryCubit(fetchData: fetchCategory),
        ),
      ],
      child: runZonedGuarded(() => child, (object, stack) {
        debugPrint("Error: $object");
      })!,
    );
  }
}
