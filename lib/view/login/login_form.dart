import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:la_vie_app/core/components/default_button.dart';
import 'package:la_vie_app/core/components/default_text_form_field.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';
import 'package:la_vie_app/cubit/login/login_cubit.dart';
import 'package:la_vie_app/layouts/main/main_layout.dart';

import '../../core/utils/navigation.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoginSuccessfulState) {
          NavigationUtils.navigateAndClearStack(
              context: context, destinationScreen: HomeLayout());
        } else if (state is LoginErrorState) {
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
                  (state is LoginLoadingState)
                      ? const Center(child: CircularProgressIndicator())
                      : DefaultButton(
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: "Login"),
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
                            await cubit.googleLogin();
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
