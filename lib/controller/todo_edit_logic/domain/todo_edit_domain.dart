import 'package:todoapp/controller/todo_edit_logic/data/todo_edit_data.dart';
import 'package:todoapp/controller/todo_edit_logic/repo/todo_edit_repo.dart';

class TodoEditDomain extends UpdateTodoEditRepo {
  final TodoEditData todoEditData;
  TodoEditDomain({required this.todoEditData});
  @override
  Future<void> updateTodo({required String id, required String value,required String key}) async {
    await todoEditData.updateTodo(id: id, value: value,key: key);
  }
}
