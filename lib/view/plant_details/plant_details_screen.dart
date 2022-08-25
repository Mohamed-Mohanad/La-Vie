import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/models/products/plant.dart';
import 'package:la_vie_app/view/blog/blog_screen.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';
import 'package:la_vie_app/view/plant_details/components/plant_info_icon.dart';

class PlantDetailsScreen extends StatelessWidget {
  final Plant plant;
  const PlantDetailsScreen({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NavigationUtils.navigateAndClearStack(
          context: context,
          destinationScreen: HomeLayout(),
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackGroundColor,
              image: DecorationImage(
                image: const AssetImage(
                  "assets/images/profile_bg.jpg",
                ),
                fit: BoxFit.cover,
                onError: (object, trace) => const SizedBox(),
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Scaffold(
                extendBody: true,
                backgroundColor: Colors.transparent,
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PlantInfoIcon(
                            icon: Icons.wb_sunny_outlined,
                            text: "Sun light",
                            percentage: "${plant.sunLight}%",
                          ),
                          PlantInfoIcon(
                            icon: Icons.water_drop_outlined,
                            text: "Water capacity",
                            percentage: "${plant.waterCapacity}%",
                          ),
                          PlantInfoIcon(
                            icon: Icons.thermostat_outlined,
                            text: "Temperature",
                            percentage: "${plant.temperature}\xB0c",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.lightBackGroundColor,
                            borderRadius: BorderRadius.circular(20.r)),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plant.name.toString(),
                                style: AppTextStyle.headLine()
                                    .copyWith(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Native to southern Africa, snake plants are well adapted to conditions similar to those in southern regions of the United States. Because of this, they may be grown outdoors for part of all of the year in USDA zones 8 and warmer",
                                style: AppTextStyle.caption(),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "Common ${plant.name} Plant Diseases",
                                style: AppTextStyle.headLine()
                                    .copyWith(fontSize: 20),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                "A widespread problem with snake plants is root rot. This results from over-watering the soil of the plant and is most common in the colder months of the year. When room rot occurs, the plant roots can die due to a lack of oxygen and an overgrowth of fungus within the soil. If the snake plant's soil is soggy, certain microorganisms such as Rhizoctonia and Pythium can begin to populate and multiply, spreading disease throughout th",
                                style: AppTextStyle.caption(),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              DefaultButton(
                                onPress: () {
                                  NavigationUtils.navigateTo(
                                    context: context,
                                    destinationScreen: BlogScreen(),
                                  );
                                },
                                borderRadius: 15.r,
                                text: "Go To Blog",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
