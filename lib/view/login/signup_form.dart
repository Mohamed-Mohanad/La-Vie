import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/login/login_cubit.dart';
import 'package:la_vie_app/layouts/main/main_layout.dart';


import '../../core/components/default_button.dart';
import '../../core/components/default_text_form_field.dart';

class SignupForm extends StatelessWidget {
  SignupForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
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
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Form(
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
                      )),
                      Expanded(
                          child: Text(
                        "Last name",
                        style: AppTextStyle.bodyText(),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultTextFormField(
                            textInputType: TextInputType.name,
                            controller: firstNameController,
                            isFilled: true),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: DefaultTextFormField(
                            textInputType: TextInputType.name,
                            controller: lastNameController,
                            isFilled: true),
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
                      isFilled: true),
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
                  (state is CreateUserLoadingState)
                      ? const Center(child: CircularProgressIndicator())
                      : DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.createUser(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: "Sign up"),
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
                          ))
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
