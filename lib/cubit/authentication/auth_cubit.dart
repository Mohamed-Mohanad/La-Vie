import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:la_vie_app/models/authentication/authentication_model.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';

import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(LoginInitial());
  static AuthenticationCubit get(context) => BlocProvider.of(context);
  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeCurrentTabBarItem());
  }

  AuthenticationModel? loginResponse;
  void login({required String email, required String password}) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url: EndPoints.LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      loginResponse = AuthenticationModel.fromJson(value.data);
      CacheHelper.saveData(
          key: "accessToken", value: loginResponse!.useAuthData.accessToken);
      CacheHelper.saveData(
          key: "userId", value: loginResponse!.useAuthData.userId);
      emit(LoginSuccessfulState());
    }).catchError((error) {
      if (error is DioError) {
        emit(LoginErrorState(
            message: error.response!.data["message"].toString()));
      }
    });
  }

  AuthenticationModel? signupResponse;
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
      signupResponse = AuthenticationModel.fromJson(value.data);
      CacheHelper.saveData(
          key: "accessToken", value: signupResponse!.useAuthData.accessToken);
      CacheHelper.saveData(
          key: "userId", value: signupResponse!.useAuthData.userId);
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
    emit(LoginLoadingState());
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
    AuthenticationModel? googleAuthResponse;
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
      googleAuthResponse = AuthenticationModel.fromJson(value.data);
      CacheHelper.saveData(
          key: "accessToken", value: googleAuthResponse!.useAuthData.accessToken);
      CacheHelper.saveData(
          key: "userId", value: googleAuthResponse!.useAuthData.userId);

      emit(LoginSuccessfulState());
    });
  }
}
