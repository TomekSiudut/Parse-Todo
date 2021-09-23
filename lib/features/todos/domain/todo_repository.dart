import 'package:todo/core/data/result.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';

abstract class TodoRepository {
  Future<Result> createTodo(TodoEntity todo);
}
