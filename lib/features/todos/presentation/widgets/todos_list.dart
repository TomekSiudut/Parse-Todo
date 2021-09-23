import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/todos_list_cubit.dart';
import 'package:todo/features/todos/presentation/widgets/todo_tile.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosListCubit(getIt<TodoRepository>()),
      child: TodosListWidget(),
    );
  }
}

class TodosListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosListCubit, Result>(
      builder: (context, state) {
        var cubit = context.watch<TodosListCubit>();
        if (state is Initial) {
          cubit.getAllTodos();
        }
        if (state is Success) {
          final data = state.data ?? [];
          if (data.isEmpty) {
            return Center(
                child: Container(
                    child: Text(
                        "You have no todos. Click + button and create one !")));
          }
          return Padding(
            padding: EdgeInsets.all(5.0.w),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return TodoTile(todo: data[index]);
                }),
          );
        } else if (state is Loading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
