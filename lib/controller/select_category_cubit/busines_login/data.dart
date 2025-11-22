import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/repo.dart';

class SelectCategoryReadData extends ReadSelectCategoryRepo<CategoryModel> {
  final Database database;
  SelectCategoryReadData({required this.database});
  @override
  Future<CategoryModel> selectCategoryById(int id) async{
    try {
      final List<Map<String, Object?>> maps = await database.query(
        'categories',
        where: 'id = ?',
        whereArgs: [id],
      );
      if (maps.isNotEmpty) {
        return CategoryModel.fromJson(maps.first);
      } else {
        throw Exception('Category not found');
      }
    } catch (e) {
      throw Exception('Database error: $e');
    }
  }
}
