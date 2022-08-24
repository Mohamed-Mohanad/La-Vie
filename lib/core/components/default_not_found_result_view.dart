import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';

class NotFoundResultView extends StatelessWidget {
  const NotFoundResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 35.h,
        ),
        Image(
          image: const AssetImage(
            "assets/images/not-found.jpeg",
          ),
          fit: BoxFit.cover,
          height: 250.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Your cart is empty",
          style: AppTextStyle.bodyText(),
        ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          "Sorry, the keyword you entered cannot be found, please check again or search with another keyword.",
          textAlign: TextAlign.center,
          style: AppTextStyle.subTitle(),
        ),
      ],
    );
  }
}
