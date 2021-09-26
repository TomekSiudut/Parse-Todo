import 'package:injectable/injectable.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:todo/core/data/handle_response.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/features/todos/data/todo.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<Result> createTodo(TodoEntity todo) async {
    final newTodo = Todo();

    if (todo.id != null) {
      newTodo.objectId = todo.id;
    }
    newTodo.title = todo.title;
    newTodo.priority = todo.priority;

    ParseResponse response = await newTodo.save();

    if (response.success && response.result != null) {
      if (response.result is Todo) {
        Todo entity = (response.result as Todo);
        return Result.success(entity);
      }
    }
    return Result.error("something went wrong");
  }

  @override
  Future<Result<List<TodoEntity>?>> getTodos() async {
    QueryBuilder query = QueryBuilder<Todo>(Todo())
      ..orderByDescending(Todo.keyCreatedAt)
      ..setLimit(200);
    var response = await responseResultList<TodoEntity, Todo>(
      () => query.query(),
      mapToEntity: (Todo todo) {
        return todo.mapToEntity();
      },
    );
    return response;
  }

  @override
  Future<Result> deleteTodo(String todoId) async {
    var todo = ParseObject('Todo')..objectId = todoId;
    final response = await todo.delete();
    if (response.success) {
      return Result.success("ok");
    } else {
      return Result.error("something went wrong");
    }
  }
}
