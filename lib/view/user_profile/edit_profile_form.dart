import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/user/user_cubit.dart';
import 'package:la_vie_app/view/user_profile/custom_input_field.dart';

import '../../core/components/default_text_form_field.dart';

class EditProfileForm extends StatelessWidget {
  EditProfileForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        if (cubit.userDataResponse != null) {
          firstNameController.text = cubit.userDataResponse!.data.firstName;
          lastNameController.text = cubit.userDataResponse!.data.lastName;
          emailController.text = cubit.userDataResponse!.data.email;
          addressController.text = cubit.userDataResponse!.data.address;
        }
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Profile",
                    style: AppTextStyle.headLine(),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.updateUserDate(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          address: addressController.text,
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.check,
                      color: AppColors.darkPrimaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomInputField(
                title: "Change Name",
                textFields: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    DefaultTextFormField(
                      textInputType: TextInputType.name,
                      controller: firstNameController,
                      labelText: "First name",
                      hasBorder: false,
                      isFilled: true,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    DefaultTextFormField(
                      textInputType: TextInputType.name,
                      controller: lastNameController,
                      labelText: "Last name",
                      hasBorder: false,
                      isFilled: true,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomInputField(
                title: "Change Email",
                textFields: DefaultTextFormField(
                  textInputType: TextInputType.name,
                  controller: emailController,
                  labelText: "E_mail",
                  hasBorder: false,
                  isFilled: true,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomInputField(
                title: "Change Address",
                textFields: DefaultTextFormField(
                  textInputType: TextInputType.name,
                  controller: addressController,
                  labelText: "Address",
                  hasBorder: false,
                  isFilled: true,
                  validation: (value) {
                    return;
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              if (state is UpdateUserDataLoadingState)
                const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.darkPrimaryColor,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
