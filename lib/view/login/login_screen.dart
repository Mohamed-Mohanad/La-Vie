import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/cubit/login/login_cubit.dart';
import 'package:la_vie_app/view/login/login_form.dart';
import 'package:la_vie_app/view/login/signup_form.dart';
import 'package:la_vie_app/view/login/tab_bar_item.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final List<Widget> tabBarActions = [LoginForm(), SignupForm()];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.lightBackGroundColor,
          image: DecorationImage(
              image: AssetImage(
                "assets/images/background.jpg",
              ),
              fit: BoxFit.cover)),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 80.h,
                  ),
                  Image.asset(
                    "assets/logo/logo.png",
                    height: 100.h,
                    width: 100.w,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TabBarItem(
                          title: "Login",
                          isActive: cubit.currentTabBarItem == 0,
                          onTap: () {
                            cubit.changeCurrentTabBarItem(0);
                          }),
                      TabBarItem(
                          title: "Signup",
                          isActive: cubit.currentTabBarItem == 1,
                          onTap: () {
                            cubit.changeCurrentTabBarItem(1);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  tabBarActions[cubit.currentTabBarItem],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
