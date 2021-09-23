import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/features/todos/domain/todo_entity.dart';
import 'package:todo/features/todos/presentation/widgets/todo_tile.dart';

class TodosList extends StatelessWidget {
  final List<TodoEntity> data;
  TodosList({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0.w),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, index) {
            return TodoTile(todo: data[index]);
          }),
    );
  }
}
