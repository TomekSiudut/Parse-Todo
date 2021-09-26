import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/result.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/todo_cubit.dart';
import 'package:todo/features/todos/presentation/widgets/basic_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final Function()? onBack;
  final String todoId;

  DeleteConfirmDialog({this.onBack, required this.todoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(getIt<TodoRepository>()),
      child: DeleteConfirmWidget(
        onBack: onBack,
        todoId: todoId,
      ),
    );
  }
}

class DeleteConfirmWidget extends StatelessWidget {
  final Function()? onBack;
  final String todoId;

  DeleteConfirmWidget({this.onBack, required this.todoId});

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
            children: <Widget>[
              Text("Do you really want to delete this todo ?",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20.0.h,
              ),
              state.when(() => buttons(context, cubit),
                  loading: () => CircularProgressIndicator(),
                  initial: () => buttons(context, cubit),
                  error: (message) => buttons(context, cubit),
                  success: (data) => buttons(context, cubit))
            ],
          ),
        );
      },
    );
  }

  Widget buttons(BuildContext context, TodoCubit cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextButton(
            onPressed: () {
              cubit.deleteTodo(todoId);
            },
            child: Text("Yes"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.blue,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"),
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
