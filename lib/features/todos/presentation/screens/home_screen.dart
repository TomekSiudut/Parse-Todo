import "package:flutter/material.dart";
import 'package:todo/features/todos/presentation/widgets/add_todo_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parse Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => AddTodoDialog());
        },
        child: Icon(Icons.add, size: 25.0.w),
      ),
    );
  }
}
