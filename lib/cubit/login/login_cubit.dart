import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie_app/models/login/SignupResponse.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';

import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeCurrentTabBarItem());
  }

  SignUpInResponse? loginResponse;
  void login({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: EndPoints.LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      loginResponse = SignUpInResponse.fromJson(value.data);
      CacheHelper.saveData(
          key: "accessToken", value: loginResponse!.data.accessToken);
      emit(LoginSuccessfulState());
    }).catchError((error) {
      if (error is DioError) {
        emit(LoginErrorState(
            message: error.response!.data["message"].toString()));
      }
    });
  }

  SignUpInResponse? signupResponse;
  void createUser(
      {required String firstName,
      required String lastName,
      required String email,
      required String password}) {
    emit(CreateUserLoadingState());
    DioHelper.postData(url: EndPoints.SIGNUP, data: {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    }).then((value) {
      signupResponse = SignUpInResponse.fromJson(value.data);
      CacheHelper.saveData(
          key: "accessToken", value: signupResponse!.data.accessToken);
      emit(CreateUserSuccessfulState());
    }).catchError((error) {
      if (error is DioError) {
        emit(CreateUserErrorState(
            message: error.response!.data["message"].toString()));
      }
    });
  }

  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleSignIn == null) {
      emit(LoginErrorState(message: "something went wrong.."));
      return;
    }
    _user = googleUser;
    final googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    DioHelper.postData(
      url: EndPoints.GOOGLE_LOGIN,
      data: {
        "id": _user!.id,
        "email": _user!.email,
        "firstName": _user!.displayName!.split(' ')[0],
        "lastName": _user!.displayName!.split(' ')[1],
        "picture": _user!.photoUrl,
      },
    ).then((value) {
      CacheHelper.saveData(key: "accessToken", value: _user!.serverAuthCode);
      emit(LoginSuccessfulState());
    });
  }
}
