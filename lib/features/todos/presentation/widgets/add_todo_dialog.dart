import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTodoDialog extends StatelessWidget {
  const AddTodoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            SizedBox(
              height: 20.0.h,
            ),
            TextField(),
            SizedBox(
              height: 20.0.h,
            ),
            TextButton(
              onPressed: () {},
              child: Text("Add"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.blue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
