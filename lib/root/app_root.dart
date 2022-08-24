import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:la_vie_app/core/style/themes/light_theme.dart';
import 'package:la_vie_app/cubit/cart/cart_cubit.dart';
import 'package:la_vie_app/cubit/discussion_forumn/discussion_forum_cubit.dart';
import 'package:la_vie_app/cubit/home/home_cubit.dart';
import 'package:la_vie_app/cubit/login/login_cubit.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';

import '../cubit/main/main_cubit.dart';
import '../layouts/splash/splash_screen.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MainCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => CartCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => DiscussionForumCubit(),
        ),
      ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, widget) => MaterialApp(
              builder: (context, widget) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaleFactor: 1.0.sp,
                  ),
                  child: widget!,
                );
              },
              debugShowCheckedModeBanner: false,
              title: "La Vie",
              theme: lightTheme,
              home: const SplashScreen(),
            ),
          );
        },
      ),
    );
  }
}
