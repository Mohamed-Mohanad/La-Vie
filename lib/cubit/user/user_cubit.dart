import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie_app/models/user/user_model.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: EndPoints.USER_DATA,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      userModel = UserModel.fromJson(value.data['data']);
      emit(GetUserDataSuccessfulState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  String _base64Image = "";
  ImagePicker imagePicker = ImagePicker();
  File? uploadedProfileImage;
  Future<void> uploadUserProfileImage() async {
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        uploadedProfileImage = File(value.path);
        Uint8List bytes = uploadedProfileImage!.readAsBytesSync();
        _base64Image = base64.encode(bytes);
        _base64Image =
            "data:image/${value.name.split('.').last};base64,$_base64Image";
      }
      emit(UploadImageSuccessful());
    });
  }

  void updateProfilePicture() {
    emit(UpdateProfilePictureLoadingState());
    DioHelper.patchData(
      url: EndPoints.UPDATE_PROFILE,
      data: {
        "imageUrl": _base64Image,
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      userModel!.imageUrl = value.data["data"]["imageUrl"];
      emit(UpdateProfilePictureSuccessfulState());
    }).catchError((error) {
      emit(UpdateProfilePictureErrorState());
    });
  }

  void updateUserDate({
    required String firstName,
    required String lastName,
    required String email,
    required String address,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.patchData(
      url: EndPoints.UPDATE_PROFILE,
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      emit(UpdateUserDataSuccessfulState());
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState(
          message: error.response!.data["message"].toString()));
    });
  }
}
