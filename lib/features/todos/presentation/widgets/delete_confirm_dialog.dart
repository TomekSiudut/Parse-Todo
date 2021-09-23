import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/util/dependencies.dart';
import 'package:todo/features/todos/domain/todo_repository.dart';
import 'package:todo/features/todos/presentation/bloc/todo_cubit.dart';
import 'package:todo/features/todos/presentation/widgets/basic_dialog.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final Function()? onBack;
  DeleteConfirmDialog({this.onBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(getIt<TodoRepository>()),
      child: DeleteConfirmWidget(
        onBack: onBack,
      ),
    );
  }
}

class DeleteConfirmWidget extends StatelessWidget {
  final Function()? onBack;
  DeleteConfirmWidget({this.onBack});

  @override
  Widget build(BuildContext context) {
    return BasicDialog();
  }
}
