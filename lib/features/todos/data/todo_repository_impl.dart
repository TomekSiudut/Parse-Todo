import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/features/todos/data/todo.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<Result> createTodo(TodoEntity todo) async {
    final newTodo = Todo();

    newTodo.title = todo.title;
    newTodo.priority = todo.priority;

    ParseResponse response = await newTodo.save();

    if (response.success && response.result != null) {
      if (response.result is Todo) {
        Todo entity = (response.result as Todo);
        return Result.success(entity);
      }
    }
    return Result.error("Something went wrong");
  }
}
