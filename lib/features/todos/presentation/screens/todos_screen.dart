import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/todos_list_cubit.dart';
import 'package:todo/features/todos/presentation/widgets/add_todo_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/todos/presentation/widgets/todos_list.dart';

class TodosScreen extends StatelessWidget {
  const TodosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosListCubit(getIt<TodoRepository>()),
      child: TodosPage(),
    );
  }
}

class TodosPage extends StatelessWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parse Todo App"),
      ),
      body: BlocBuilder<TodosListCubit, Result>(
        builder: (context, state) {
          var cubit = context.watch<TodosListCubit>();
          if (state is Initial) {
            cubit.init();
          }
          if (state is Success) {
            final data = state.data ?? [];
            if (data.length == 0) {
              return Center(
                  child: Container(
                      child: Text(
                          "You have no todos. Click + button and create one !")));
            }
            return TodosList(
              data: data,
              onBack: cubit.refresh,
            );
          } else if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AddTodoDialog(onBack: () {
                    context.read<TodosListCubit>().refresh();
                  }));
        },
        child: Icon(Icons.add, size: 25.0.w),
      ),
    );
  }
}
