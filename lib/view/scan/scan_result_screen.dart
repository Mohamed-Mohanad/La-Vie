import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/product/product_cubit.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';
import 'package:la_vie_app/view/scan/components/plant_info_icon.dart';

class ScanResultScreen extends StatefulWidget {
  const ScanResultScreen({Key? key}) : super(key: key);

  @override
  State<ScanResultScreen> createState() => _ScanResultScreenState();
}

class _ScanResultScreenState extends State<ScanResultScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ProductCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                NavigationUtils.navigateAndClearStack(
                  context: context,
                  destinationScreen: HomeLayout(),
                );
              },
              icon: Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: AppColors.lightBackGroundColor,
              image: DecorationImage(
                image: const AssetImage("assets/images/profile_bg.jpg"),
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
                      height: 40.h,
                    ),
                    PlantInfoIcon(
                      icon: Icons.wb_sunny_outlined,
                      text: "Sun light",
                      percentage: "${cubit.scannedPlant!.sunLight} %",
                    ),
                    PlantInfoIcon(
                      icon: Icons.water_drop_outlined,
                      text: "Water capacity",
                      percentage: "${cubit.scannedPlant!.waterCapacity} %",
                    ),
                    PlantInfoIcon(
                      icon: Icons.thermostat_outlined,
                      text: "Temperature",
                      percentage: "${cubit.scannedPlant!.temperature} \xB0c",
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
                        child: Column(
                          children: [
                            Text(
                              cubit.scannedPlant!.name.toString(),
                              style: AppTextStyle.headLine(),
                            ),
                            Text(
                              cubit.scannedPlant!.description.toString(),
                              style: AppTextStyle.subTitle(),
                            ),
                            Expanded(
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.network(
                                    "https://lavie.orangedigitalcenteregypt.com${cubit.scannedPlant!.imageUrl}",
                                    height: 150.h,
                                    width: 150.w,
                                    fit: BoxFit.cover,
                                    errorBuilder: (
                                      context,
                                      object,
                                      trace,
                                    ) =>
                                        Image.asset(
                                      "assets/images/grid1.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            DefaultButton(
                              onPress: () {
                                NavigationUtils.navigateTo(
                                  context: context,
                                  destinationScreen: HomeLayout(),
                                );
                              },
                              borderRadius: 15.r,
                              text: "Go To Blog",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
