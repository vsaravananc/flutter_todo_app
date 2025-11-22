abstract class TodoEditRepo {}

abstract class UpdateTodoEditRepo extends TodoEditRepo {
  Future<void> updateTodo({
    required String id,
    required String value,
    required String key,
  });
}
