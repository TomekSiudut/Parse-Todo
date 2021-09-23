import 'package:bloc/bloc.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';

class TodoCubit extends Cubit<Result> {
  final TodoRepository repository;
  TodoCubit(this.repository) : super(Result.initial());

  createTodo(TodoEntity todo) async {
    emit(Result.loading());
    final result = await repository.createTodo(todo);
    emit(result);
  }
}
