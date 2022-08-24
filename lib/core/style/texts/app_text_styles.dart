import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headLine() => TextStyle(
        fontSize: 23.0.sp,
        fontWeight: FontWeight.w800,
        color: Colors.black,
        fontFamily: "Roboto",
      );

  static TextStyle appBarText() => TextStyle(
        color: Colors.black,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Roboto",
      );

  static TextStyle bodyText() => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: "Roboto",
      );

  static TextStyle caption() => TextStyle(
        fontSize: 13.0.sp,
        color: Colors.grey,
    fontFamily: "Roboto",
      );
  static TextStyle subTitle() => TextStyle(
        fontSize: 14.0.sp,
        color: Colors.grey,
        height: 1.3.h,
        fontFamily: "Roboto",
      );
}
