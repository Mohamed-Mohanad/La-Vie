import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie_app/models/user/uploaded_image.dart';
import 'package:la_vie_app/models/user/user_data_response.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);

  UserDataResponse? userDataResponse;
  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(
      url: EndPoints.USER_DATA,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      userDataResponse = UserDataResponse.fromJson(value.data);
      emit(GetUserDataSuccessfulState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  UploadedImage? uploadedImage;
  Future<void> uploadImage() async {
    String base64Image = "";
    final ImagePicker imagePicker = ImagePicker();
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) async {
      if (value != null) {
        final resultFile = File(value.path);
        Uint8List bytes = await resultFile.readAsBytes();
        base64Image = base64.encode(bytes);
        base64Image =
            "data:image/${value.name.split('.').last};base64,$base64Image";
        uploadedImage =
            UploadedImage(base64Image: base64Image, file: resultFile);
        emit(UploadImageSuccessful());
        updateProfilePicture(base64Image);
      }
    });
  }

  void updateProfilePicture(String base64Image) {
    emit(UpdateProfilePictureLoadingState());
    DioHelper.patchData(
      url: EndPoints.UPDATE_PROFILE,
      data: {
        "imageUrl": base64Image,
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      userDataResponse!.data.imageUrl = value.data["data"]["imageUrl"];
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
