import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicDialog extends StatelessWidget {
  final Widget? content;

  BasicDialog({this.content});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Padding(padding: EdgeInsets.all(20.0.w), child: content));
  }
}
