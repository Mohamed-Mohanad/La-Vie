import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

import '../../../core/utils/navigation.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({
    Key? key,
    required this.title,
    required this.textFields,
  }) : super(key: key);
  String title;
  Widget textFields;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  contentPadding: const EdgeInsets.all(20),
                  content: textFields,
                  actions: [
                    TextButton(
                        onPressed: () {
                          NavigationUtils.navigateBack(context: context);
                        },
                        child: const Text(
                          "ok",
                        ))
                  ],
                ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            width: 1,
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: AppColors.darkPrimaryColor,
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
              child: const Icon(
                Icons.mode_edit_outlined,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              title,
              style: AppTextStyle.bodyText(),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward,
              color: AppColors.darkPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
