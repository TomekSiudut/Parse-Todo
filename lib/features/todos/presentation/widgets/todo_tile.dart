import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/presentation/widgets/add_todo_dialog.dart';
import 'package:todo/features/todos/presentation/widgets/delete_confirm_dialog.dart';

class TodoTile extends StatelessWidget {
  final TodoEntity todo;
  final Function()? onBack;
  TodoTile({required this.todo, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.w,
        child: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(todo.title ?? "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue)),
                    Row(
                      children: <Widget>[
                        InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) => AddTodoDialog(
                                      onBack: onBack,
                                      todo: todo,
                                    )),
                            child: Container(
                                child: Icon(Icons.edit, color: Colors.blue))),
                        SizedBox(width: 20.w),
                        InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (_) => DeleteConfirmDialog(
                                      onBack: onBack,
                                      todoId: todo.id ?? "",
                                    )),
                            child: Container(
                                child: Icon(Icons.delete, color: Colors.red))),
                      ],
                    )
                  ],
                ),
              )),
        ));
  }
}
