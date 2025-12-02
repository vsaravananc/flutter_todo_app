import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/data.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/domain.dart';
import 'package:todoapp/controller/select_category_cubit/selectcategory_cubit.dart';
import 'package:todoapp/controller/todo_controller/bloc/todo_bloc.dart';
import 'package:todoapp/controller/todo_controller/data/use_case/todo_data.dart';
import 'package:todoapp/controller/todo_controller/domain/todo_domain.dart';
import 'package:todoapp/controller/todo_edit_logic/controller/todo_edit_controller.dart';
import 'package:todoapp/controller/todo_edit_logic/data/todo_edit_data.dart';
import 'package:todoapp/controller/todo_edit_logic/domain/todo_edit_domain.dart';
import 'package:todoapp/core/platform/device_verion.dart';
import 'package:todoapp/core/route/routes.dart';
import 'package:todoapp/core/services/shared_preference_services.dart';
import 'package:todoapp/core/themes/theme.dart';
import 'package:todoapp/database/create_db.dart';
import 'package:todoapp/controller/category_controller/bloc/home_bloc_bloc.dart';
import 'package:todoapp/controller/category_controller/data/use_case/home_data.dart';
import 'package:todoapp/controller/category_controller/domain/home_domain.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  if (kReleaseMode == true) {
    await SentryFlutter.init(
      (options) {
        options.dsn =
            'https://ff712c9132906bd2a58b5f5acbb456e1@o4510412501876736.ingest.de.sentry.io/4510412506792016';
        options.tracesSampleRate = 1.0;
      },
      appRunner: () {
        FlutterError.onError = (FlutterErrorDetails details) {
          Sentry.captureException(
            details.exception,
            stackTrace: details.stack,
            message: SentryMessage("UI issues"),
          );
        };
        runZonedGuarded(
          () async =>
              runApp(await DependencyInjection.injectBloc(const MyApp())),
          (e, s) {
            Sentry.captureException(
              e,
              stackTrace: s,
              message: SentryMessage("Zoned issues"),
            );
          },
        );
      },
    );
  } else {
    runApp(await DependencyInjection.injectBloc(const MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: const ValueKey('material-app'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      themeMode: ThemeMode.light,
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
    final DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    DeviceInfoImpl info = DeviceInfoImpl.init(deviceInfoPlugin: infoPlugin);
    SharedPreferenceServices.init(
      preferences: await SharedPreferences.getInstance(),
    );
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
    ValueNotifier<bool> deviceInfo = ValueNotifier(false);
    deviceInfo.value = await info.isAndroid11;
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
            deletedCategory: DeleteCategoryDomain(
              deleteCategoryData: DeleteCategoryData(database: database),
              loadedCategory: loadCategoryDomain,
            ),
            editCategory: EditCategoryDomain(
              editCategoryData: EditCategoryData(database: database),
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
      child: runZonedGuarded(
        () => DeviceProvider(notifier: deviceInfo, child: child),
        (object, stack) {
          debugPrint("Error: $object");
        },
      )!,
    );
  }
}
