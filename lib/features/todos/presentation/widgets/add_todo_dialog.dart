import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/add_todo_cubit.dart';
import 'package:todo/features/todos/presentation/bloc/text_input_cubit.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddTodoCubit(getIt<TodoRepository>()),
      child: AddTodoWidget(),
    );
  }
}

class AddTodoWidget extends StatelessWidget {
  AddTodoWidget({Key? key}) : super(key: key);

  final inputCubit = TextInputCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTodoCubit, Result>(
      listener: (context, state) {
        if (state is Success) {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        var cubit = context.watch<AddTodoCubit>();
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Add New Todo",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue)),
                SizedBox(
                  height: 20.0.h,
                ),
                TextField(
                  onChanged: (text) => inputCubit.onChanged(text),
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                state.when(() => button(context, cubit, inputCubit),
                    loading: () => CircularProgressIndicator(),
                    initial: () => button(context, cubit, inputCubit),
                    error: (message) => button(context, cubit, inputCubit),
                    success: (data) => button(context, cubit, inputCubit))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget button(
      BuildContext context, AddTodoCubit cubit, TextInputCubit inputCubit) {
    return TextButton(
      onPressed: () {
        final newTodo =
            TodoEntity(title: inputCubit.getValue(), priority: false);
        cubit.createTodo(newTodo);
      },
      child: Text("Add"),
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
