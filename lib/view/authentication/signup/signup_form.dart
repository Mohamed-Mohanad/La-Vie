import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/authentication/auth_cubit.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';

import '../../../core/components/default_button.dart';
import '../../../core/components/default_text_form_field.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is CreateUserSuccessfulState) {
          NavigationUtils.navigateAndClearStack(
              context: context, destinationScreen: HomeLayout());
        } else if (state is CreateUserErrorState) {
          Fluttertoast.showToast(
            msg: state.message!,
            backgroundColor: Colors.black54,
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "First name",
                      style: AppTextStyle.bodyText(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Last name",
                      style: AppTextStyle.bodyText(),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: DefaultTextFormField(
                      textInputType: TextInputType.name,
                      controller: firstNameController,
                      isFilled: true,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: DefaultTextFormField(
                      textInputType: TextInputType.name,
                      controller: lastNameController,
                      isFilled: true,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "E-mail",
                style: AppTextStyle.bodyText(),
              ),
              DefaultTextFormField(
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                isFilled: true,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                "Password",
                style: AppTextStyle.bodyText(),
              ),
              DefaultTextFormField(
                textInputType: TextInputType.visiblePassword,
                controller: passwordController,
                isPassword: true,
                isFilled: true,
                maxLines: 1,
              ),
              SizedBox(
                height: 20.h,
              ),
              BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (_, state) {
                  return (state is CreateUserLoadingState)
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : DefaultButton(
                          height: 38.h,
                          borderRadius: 10.r,
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              AuthenticationCubit.get(context).createUser(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: "Sign up",
                        );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      "or continue with",
                      style: AppTextStyle.subTitle(),
                    ),
                  ),
                  const Expanded(
                    child: Divider(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        "assets/icons/google.png",
                        height: 25.h,
                        width: 25.w,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    width: 10.w,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset(
                      "assets/icons/facebook.png",
                      height: 25.h,
                      width: 25.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
