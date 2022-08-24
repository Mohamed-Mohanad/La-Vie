import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';
import 'package:la_vie_app/view/user_profile/edit_profile_form.dart';
import 'package:la_vie_app/view/user_profile/profile_picture.dart';
import 'package:la_vie_app/view/user_profile/user_points_view.dart';

import 'logout_dialog.dart';

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
                body: (cubit.userDataResponse == null)
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            ProfilePicture(
                                url: cubit.userDataResponse!.data.imageUrl),
                            Text(
                              "${cubit.userDataResponse!.data.firstName} ${cubit.userDataResponse!.data.lastName}",
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
                                          points: cubit.userDataResponse!.data
                                              .userPoints),
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
