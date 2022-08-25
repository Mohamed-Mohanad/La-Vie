import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/main/main_cubit.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';
import 'package:la_vie_app/view/user_profile/components/edit_profile_form.dart';
import 'package:la_vie_app/view/user_profile/components/profile_picture.dart';
import 'package:la_vie_app/view/user_profile/components/user_points_view.dart';

import 'components/logout_dialog.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserCubit.get(context).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColors.lightBackGroundColor,
          image: DecorationImage(
            image: AssetImage("assets/images/profile_bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              // TODO: implement listener
              if (state is UpdateUserDataSuccessfulState) {
                Fluttertoast.showToast(
                  msg: "Updated successfully",
                  backgroundColor: Colors.black54,
                );
              } else if (state is UpdateUserDataErrorState) {
                Fluttertoast.showToast(
                  msg: state.message,
                  backgroundColor: Colors.black54,
                );
              }
            },
            builder: (context, state) {
              var cubit = UserCubit.get(context);
              return Scaffold(
                extendBody: true,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  leading: IconButton(onPressed: (){
                    NavigationUtils.navigateBack(context: context);
                    MainCubit.get(context).changeCurrentNavBarItem(2);
                  }, icon: Icon(Icons.arrow_back),),
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(color: Colors.white),
                  systemOverlayStyle: const SystemUiOverlayStyle(
                      statusBarIconBrightness: Brightness.light),
                  actions: [
                    IconButton(
                        onPressed: () {
                          logoutAlertDialog(context);
                        },
                        icon: const Icon(Icons.logout))
                  ],
                ),
                body: (cubit.userModel == null)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            ProfilePicture(url: cubit.userModel!.imageUrl!),
                            Text(
                              "${cubit.userModel!.firstName!} ${cubit.userModel!.lastName!}",
                              style: AppTextStyle.bodyText()
                                  .copyWith(color: Colors.white),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: AppColors.lightBackGroundColor,
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      UserPointsView(
                                          points:
                                              cubit.userModel!.userPoints ?? 0),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      EditProfileForm(),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
        ));
  }
}
