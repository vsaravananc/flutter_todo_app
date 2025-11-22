import 'package:sqflite/sqflite.dart';
import 'package:todoapp/controller/todo_edit_logic/repo/todo_edit_repo.dart';

class TodoEditData extends UpdateTodoEditRepo {
  final Database database;
  TodoEditData({required this.database});
  @override
  Future<void> updateTodo({required String id, required String value,required String key}) async {
     await database.update(
      'todos',
      {key: value},
      where: 'id = ?',
      whereArgs: [int.parse(id)],
    );
  }
}
