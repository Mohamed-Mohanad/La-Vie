import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColors.lightBackGroundColor,
        borderRadius: BorderRadius.circular(
          15.r,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: -3,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Image.network(
                "https://img.freepik.com/free-psd/green-houseplant-mockup-psd-banner_53876-137827.jpg?w=1380&t=st=1661300452~exp=1661301052~hmac=322e9c03e18a19226627fdef7d290c7a27832075e8154e459b75b9355042e882",
                height: 100.h,
                width: 130.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 5.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2 days ago",
                    style: AppTextStyle.subTitle()
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text('5 Tips to treat plants',
                      style: AppTextStyle.bodyText()),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'leaf, in botany, any usually, leaf, in botany, any usually',
                    style: AppTextStyle.caption(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
