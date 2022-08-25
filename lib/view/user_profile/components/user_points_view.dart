import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

class UserPointsView extends StatelessWidget {
  UserPointsView({Key? key, required this.points}) : super(key: key);
  int points;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            "You have $points points",
            style: AppTextStyle.bodyText(),
          ),
        ],
      ),
    );
  }
}
