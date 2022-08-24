import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/layouts/main/main_layout.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/view/login/login_screen.dart';

import '../../core/utils/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Widget destinationScreen;
    if (CacheKeysManger.getUserTokenFromCache() != '') {
      destinationScreen = HomeLayout();
    } else {
      destinationScreen = LoginScreen();
    }
    Timer(
      const Duration(seconds: 2),
      () => NavigationUtils.navigateAndClearStack(
        context: context,
        destinationScreen: destinationScreen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo/logo.png",
          height: 100.h,
          width: 150.w,
        ),
      ),
    );
  }
}
