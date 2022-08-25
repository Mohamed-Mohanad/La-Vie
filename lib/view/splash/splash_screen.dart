import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/view/authentication/auth_screen.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';

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
      destinationScreen = MainLayout();
    } else {
      destinationScreen = AuthScreen();
    }
    Timer(const Duration(microseconds: 500), () {
      first = false;
      setState(() {});
    });
    Timer(const Duration(seconds: 3), () {
      NavigationUtils.navigateAndClearStack(
        context: context,
        destinationScreen: destinationScreen,
      );
    });
  }

  bool first = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                firstChild: Container(),
                secondChild: SizedBox(
                  width: 280.w,
                  height: 150.h,
                  child: const Image(
                    image: AssetImage(
                      "assets/logo/logo.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                crossFadeState: first
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(seconds: 2),
              ),
              SizedBox(
                height: 15.h,
              ),
              const CircularProgressIndicator.adaptive(

              ),
            ],
          ),
        ),
      ),
    );
  }
}
