import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/core/utils/navigation.dart';
import 'package:la_vie_app/cubit/authentication/auth_cubit.dart';
import 'package:la_vie_app/view/layouts/main/main_layout.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LoginSuccessfulState) {
          NavigationUtils.navigateAndClearStack(
            context: context,
            destinationScreen: MainLayout(),
          );
        } else if (state is LoginErrorState) {
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
                BlocBuilder<AuthenticationCubit, AuthenticationState>(
                  builder: (_, state) {
                    return (state is LoginLoadingState)
                        ? Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : DefaultButton(
                            height: 38.h,
                            borderRadius: 10.r,
                            onPress: () {
                              if (_formKey.currentState!.validate()) {
                                AuthenticationCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: "Login",
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
                      padding: const EdgeInsets.all(5.0),
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
                        onPressed: () async {
                          await AuthenticationCubit.get(context).googleLogin();
                        },
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
          )),
    );
  }
}
