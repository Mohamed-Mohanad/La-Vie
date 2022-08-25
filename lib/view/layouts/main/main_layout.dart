import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/main/main_cubit.dart';
import 'package:la_vie_app/cubit/product/product_cubit.dart';
import 'package:la_vie_app/view/discussion_fourms/discussion_fourms_screen.dart';
import 'package:la_vie_app/view/home/home_screen.dart';
import 'package:la_vie_app/view/notifications/notifications_screen.dart';
import 'package:la_vie_app/view/scan/scan_screen.dart';
import 'package:la_vie_app/view/user_profile/user_profile_screen.dart';

import 'bottom_nav_bar_item.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({Key? key}) : super(key: key);
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  final List<String> navBarItems = ["leaf", "scanner", "home", "bell", "user"];
  final List<Widget> screens = [
    const DiscussionForumsScreen(),
    const SizedBox(),
    HomeScreen(),
    const NotificationsScreen(),
    const SizedBox()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).getAllProducts();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        return Scaffold(
          body: SafeArea(
            child: screens[cubit.currentNavBarItem],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 100,
                    spreadRadius: -2,
                    color: Colors.grey.shade300)
              ],
            ),
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              index: 2,
              buttonBackgroundColor: AppColors.primaryColor,
              animationCurve: Curves.easeInOut,
              onTap: (index) {
                if (index == 1) {
                  NavigationUtils.navigateTo(
                    context: context,
                    destinationScreen: ScanScreen(),
                  );
                } else if (index == 4) {
                  NavigationUtils.navigateTo(
                    context: context,
                    destinationScreen: UserProfileScreen(),
                  );
                } else {
                  cubit.changeCurrentNavBarItem(index);
                }
              },
              items: List.generate(
                navBarItems.length,
                (index) => BottomNavBarItem(
                  svgName: navBarItems[index],
                  isActive: index == cubit.currentNavBarItem,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
