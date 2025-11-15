



import 'package:todoapp/controller/category_controller/data/model/category_model.dart';

extension CategoryModelExtension on CategoryModel {
  String get actuallName => name == 'All' ? 'No Category' : name;
  bool get isAll => name == 'All';
}