import 'package:injectable/injectable.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';

@Singleton(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  @override
  Future addTodo() {
    // TODO: implement addTodo
    throw UnimplementedError();
  }
}
