import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarItem extends StatelessWidget {
  BottomNavBarItem({Key? key, required this.svgName, required this.isActive})
      : super(key: key);
  String svgName;
  bool isActive;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isActive?5:0),
      child: SvgPicture.asset(
        "assets/icons/$svgName.svg",
        height:20.h,
        width:20.w,
        color: isActive ? Colors.white : Colors.black,
      ),
    );
  }
}
