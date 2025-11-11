import 'package:flutter/foundation.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/core/services/error_handeling_service.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';

abstract class HomeDataReadeWrite {}

abstract class HomeData<T> implements HomeDataReadeWrite {
  Future<T> getData();
}

abstract class HomeDataInsert<T> implements HomeDataReadeWrite{
   Future<T> insertData({required String name});
}

///
///  LOADCATEGORYDATA CLASS : IS FETCHING THE DATA FROM THE DATABASE
///

class LoadCategoryData extends HomeData<List<CategoryModel>> {
  final Database database;

  LoadCategoryData({required this.database});

  @override
  Future<List<CategoryModel>> getData() async {
    try {
      final List<Map<String, dynamic>> result = await database.query(
        'categories',
      );
      final categories = await compute(_decodeCategoryModel, result);
      if (categories.isEmpty) {
        throw ErrorHandelingService(
          message:
              "No categories found. Try adding a new category to get started!",
          errorType: ErrorType.dataEmptyException,
        );
      }
      return categories;
    } on FormatException catch (_) {
      throw ErrorHandelingService(
        message:
            "We couldn’t read your category data correctly. Please restart the app or try again.",
        errorType: ErrorType.formateException,
      );
    } on TypeError catch (_) {
      throw ErrorHandelingService(
        message:
            "Something went wrong while loading your categories. Please try again later.",
        errorType: ErrorType.typeErrorException,
      );
    } catch (e) {
      if (e is ErrorHandelingService) {
        rethrow;
      } else {
        throw ErrorHandelingService(
          message:
              "An unexpected error occurred while fetching your categories. Please try again.",
          errorType: ErrorType.typeErrorException,
        );
      }
    }
  }
}

List<CategoryModel> _decodeCategoryModel(List<Map<String, dynamic>> data) {
  return data.map((e) => CategoryModel.fromJson(e)).toList();
}

///
///
///

class AddCategoryData extends HomeDataInsert<bool> {
  final Database database;

  AddCategoryData({required this.database});
 
  
  @override
  Future<bool> insertData({required String name}) async{
     try {
      await database.insert('categories', {'name': name});
      return true;
    } catch (e) {
      return false;
    }
  }
  
}
