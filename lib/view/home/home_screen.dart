import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/home/home_cubit.dart';
import 'package:la_vie_app/view/cart/cart_screen.dart';
import 'package:la_vie_app/view/home/grids/all_grid.dart';
import 'package:la_vie_app/view/home/grids/plants_grid.dart';
import 'package:la_vie_app/view/home/grids/seeds_grid.dart';
import 'package:la_vie_app/view/home/grids/tools_grid.dart';
import 'package:la_vie_app/view/home/tab_bar_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<String> tabBarItems = ["All", "Plants", "Seeds", "Tools"];
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        List<Widget> grids = [
          const AllGrid(),
          const PlantsGrid(),
          const SeedsGrid(),
          const ToolsGrid()
        ];
        return Column(
          children: [
            Image.asset(
              "assets/logo/logo.png",
              height: 100.h,
              width: 100.w,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: DefaultTextFormField(
                      textInputType: TextInputType.text,
                      controller: searchController,
                      prefixIcon: Icons.search_rounded,
                      borderRadius: 10.r,
                      enabledBorderRadius: 10.r,
                      hasBorder: false,
                      isFilled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      NavigationUtils.navigateTo(
                        context: context,
                        destinationScreen: CartScreen(),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColors.primaryColor,
                      ),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(
                  width: 10.w,
                ),
                itemCount: tabBarItems.length,
                itemBuilder: (context, index) => HomeTabBarItem(
                    title: tabBarItems[index],
                    isActive: index == cubit.currentTabBarItem,
                    onTap: () {
                      cubit.changeCurrentTabBarItem(index);
                    }),
              ),
            ),
            Expanded(
              child: grids[cubit.currentTabBarItem],
            )
          ],
        );
      },
    );
  }
}
