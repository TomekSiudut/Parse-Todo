import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TodosList extends StatelessWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.0.w),
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, index) {
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
                            Text("Todo title",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                            Row(
                              children: <Widget>[
                                Container(
                                    child:
                                        Icon(Icons.edit, color: Colors.blue)),
                                SizedBox(width: 20.w),
                                Container(
                                    child:
                                        Icon(Icons.delete, color: Colors.red)),
                              ],
                            )
                          ],
                        ),
                      )),
                ));
          }),
    );
  }
}
