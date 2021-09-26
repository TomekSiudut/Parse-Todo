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
  final TodoEntity? todo;
  AddTodoDialog({this.onBack, this.todo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(getIt<TodoRepository>()),
      child: AddTodoWidget(
        onBack: onBack,
        todo: todo,
      ),
    );
  }
}

class AddTodoWidget extends StatelessWidget {
  final Function()? onBack;
  final TodoEntity? todo;
  AddTodoWidget({this.onBack, this.todo});

  @override
  Widget build(BuildContext context) {
    final inputCubit = TextInputCubit();
    inputCubit.initValue(todo?.title ?? "");

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
              Text(todo != null ? "Edit Todo" : "Add New Todo",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue)),
              SizedBox(
                height: 20.0.h,
              ),
              TextFormField(
                initialValue: inputCubit.getValue(),
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
        final newTodo = TodoEntity(
            id: todo?.id ?? null,
            title: inputCubit.getValue(),
            priority: false);
        cubit.createTodo(newTodo);
      },
      child: Text(todo != null ? "Save" : "Add"),
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
