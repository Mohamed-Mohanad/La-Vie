import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';

class QuizResultScreen extends StatelessWidget {
  QuizResultScreen({Key? key, required this.result}) : super(key: key);
  final int result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            NavigationUtils.navigateAndClearStack(
              context: context,
              destinationScreen: HomeLayout(),
            );
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Result",
          style: AppTextStyle.appBarText(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Result is",
              style: AppTextStyle.headLine().copyWith(fontSize: 30),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              result.toString(),
              style: AppTextStyle.headLine()
                  .copyWith(color: AppColors.primaryColor, fontSize: 30.sp),
            )
          ],
        ),
      ),
    );
  }
}
