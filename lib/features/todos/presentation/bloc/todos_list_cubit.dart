import 'package:bloc/bloc.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';

class TodosListCubit extends Cubit<Result> {
  final TodoRepository repository;
  TodosListCubit(this.repository) : super(Result.initial());

  refresh() {
    emit(Result.initial());
  }

  init() async {
    emit(Result.loading());
    final response = await repository.getTodos();
    emit(response);
  }
}
