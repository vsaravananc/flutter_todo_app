abstract class SelectcategoryRepo {}

abstract class ReadSelectCategoryRepo<R> extends SelectcategoryRepo {
  Future<R> selectCategoryById(int id);
}
