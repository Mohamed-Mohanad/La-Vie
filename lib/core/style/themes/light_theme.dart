import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';
import '../texts/app_text_styles.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackGroundColor,
  primarySwatch: AppColors.primarySwatchColor,
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyle.appBarText(),
    elevation: 0,
    color: AppColors.lightBackGroundColor,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    elevation: 1.0,
    unselectedItemColor: Colors.grey,
    //backgroundColor: AppColors.whitBackGroundColor,
  ),
  backgroundColor: AppColors.primaryColor,
  dividerColor: Colors.grey,
  fontFamily: "Roboto",
);
