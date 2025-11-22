import 'package:todoapp/controller/category_controller/data/model/category_model.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/data.dart';
import 'package:todoapp/controller/select_category_cubit/busines_login/repo.dart';

class SelectCategoryReadDomain extends ReadSelectCategoryRepo<CategoryModel> {
  final SelectCategoryReadData fetchData;
  SelectCategoryReadDomain({required this.fetchData});
  @override
  Future<CategoryModel> selectCategoryById(int id) async{
    try {
      final categoryModel = await fetchData.selectCategoryById(id);
      return categoryModel;
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }
}
