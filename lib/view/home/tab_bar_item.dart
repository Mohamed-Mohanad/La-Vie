import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

class HomeTabBarItem extends StatelessWidget {
  HomeTabBarItem(
      {Key? key,
      required this.title,
      required this.isActive,
      required this.onTap})
      : super(key: key);
  String title;
  bool isActive;
  Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10.h),
            border: isActive
                ? Border.all(color: AppColors.primaryColor, width: 1)
                : null),
        child: Center(
          child: Text(
            title,
            style: AppTextStyle.bodyText(),
          ),
        ),
      ),
    );
  }
}
