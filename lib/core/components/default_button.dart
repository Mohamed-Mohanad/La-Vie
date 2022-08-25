import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

class DefaultButton extends StatelessWidget {
  Function onPress;
  String text;
  IconData? icon;
  double? borderRadius;
  double? height;
  Color? backgroundColor;
  Color? textColor;
  bool hasBorder;
  DefaultButton(
      {Key? key,
        required this.onPress,
        required this.text,
        this.icon,
        this.borderRadius,
        this.height,
        this.backgroundColor,
        this.textColor,
        this.hasBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height ?? 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
            color: backgroundColor ?? AppColors.primaryColor,
            border: hasBorder
                ? Border.all(color: AppColors.primaryColor, width: 1)
                : null),
        child: MaterialButton(
          onPressed: () {
            onPress();
          },
          minWidth: double.infinity,
          textColor: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppTextStyle.bodyText()
                    .copyWith(color: textColor ?? Colors.white),
              ),
              if (icon != null) Icon(icon, color: Colors.white)
            ],
          ),
        ));
  }
}
