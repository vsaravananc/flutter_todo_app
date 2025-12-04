import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class AppShowCase {
  static final GlobalKey _appBar = GlobalKey();
  static final GlobalKey _addCategory = GlobalKey();
  static final GlobalKey _todoList = GlobalKey();
  static final GlobalKey _markasdone = GlobalKey();
  static final GlobalKey _edit = GlobalKey();
  static final GlobalKey _addTask = GlobalKey();
  static void registerShowCase() => ShowcaseView.register();
  static GlobalKey get appBar => _appBar;
  static GlobalKey get addCategory => _addCategory;
  static GlobalKey get todoList => _todoList;
  static GlobalKey get markasdone => _markasdone;
  static GlobalKey get edit => _edit;
  static GlobalKey get addTask => _addTask;
  static void startShowCaseing() => ShowcaseView.get().startShowCase([
    _appBar,
    _addCategory,
    _todoList,
    _markasdone,
    _edit,
    _addTask,
  ]);
}
