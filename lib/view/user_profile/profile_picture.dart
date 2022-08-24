import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is UpdateProfilePictureErrorState) {
          Fluttertoast.showToast(
              msg:
                  "sorry, an error has occurred while updating profile picture",
              backgroundColor: Colors.black54);
        }
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 70.r,
              backgroundColor: Colors.grey.shade100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70.r),
                child: (cubit.uploadedImage == null ||
                        state is UpdateProfilePictureErrorState)
                    ? Image.network(
                        url,
                        errorBuilder: (context, object, trace) => Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.grey.shade300,
                        ),
                        fit: BoxFit.cover,
                        height: 150.w,
                        width: 150.w,
                      )
                    : Image.file(
                        cubit.uploadedImage!.file,
                        errorBuilder: (context, object, trace) => Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.grey.shade300,
                        ),
                        fit: BoxFit.cover,
                        height: 150.w,
                        width: 150.w,
                      ),
              ),
            ),
            IconButton(
                onPressed: () {
                  cubit.uploadImage();
                },
                icon: CircleAvatar(
                  backgroundColor: AppColors.lightBackGroundColor,
                  radius: 18.r,
                  child: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.darkPrimaryColor,
                  ),
                )),
          ],
        );
      },
    );
  }
}
