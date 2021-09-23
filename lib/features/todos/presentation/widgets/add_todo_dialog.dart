import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/todo_cubit.dart';
import 'package:todo/features/todos/presentation/bloc/text_input_cubit.dart';
import 'package:todo/features/todos/presentation/widgets/basic_dialog.dart';

class AddTodoDialog extends StatelessWidget {
  final Function()? onBack;
  AddTodoDialog({this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(getIt<TodoRepository>()),
      child: AddTodoWidget(
        onBack: onBack,
      ),
    );
  }
}

class AddTodoWidget extends StatelessWidget {
  final Function()? onBack;
  AddTodoWidget({this.onBack});

  final inputCubit = TextInputCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, Result>(
      listener: (context, state) {
        if (state is Success) {
          Navigator.of(context).pop();
          if (onBack != null) onBack!();
        }
      },
      builder: (context, state) {
        var cubit = context.watch<TodoCubit>();
        return BasicDialog(
          content: Column(
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
        );
      },
    );
  }

  Widget button(
      BuildContext context, TodoCubit cubit, TextInputCubit inputCubit) {
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
