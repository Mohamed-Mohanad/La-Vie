import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie_app/models/forum/forum_model.dart';
import 'package:la_vie_app/repositories/src/local/shared_preference/cache_keys.dart';
import 'package:la_vie_app/repositories/src/remote/dio/dio_helper.dart';
import 'package:la_vie_app/repositories/src/remote/dio/end_points.dart';
import 'package:meta/meta.dart';

part 'discussion_forum_state.dart';

class DiscussionForumCubit extends Cubit<DiscussionForumState> {
  DiscussionForumCubit() : super(DiscussionForumInitial());
  static DiscussionForumCubit get(context) => BlocProvider.of(context);

  int currentTabBarItem = 0;
  void changeCurrentTabBarItem(int index) {
    currentTabBarItem = index;
    emit(ChangeTabBarItem());
  }

  ForumModel? allForumModel;
  void getAllForums() {
    emit(DiscussionForumGetAllForumsLoadingState());
    DioHelper.getData(
      url: EndPoints.ALL_FORUMS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      allForumModel = ForumModel.fromJson(value.data);
      emit(DiscussionForumGetAllForumsSuccessState());
    }).catchError((error) {
      emit(DiscussionForumGetAllForumsErrorState());
    });
  }

  ForumModel? myForumModel;
  void getMyForums() {
    emit(DiscussionForumGetMyForumsLoadingState());
    DioHelper.getData(
      url: EndPoints.MY_FORUMS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      myForumModel = ForumModel.fromJson(value.data);
      emit(DiscussionForumGetMyForumsSuccessState());
    }).catchError((error) {
      emit(DiscussionForumGetMyForumsErrorState());
    });
  }

  bool liked = false;
  void likeForum(String forumId, int forumKind) {
    emit(DiscussionForumLikeLoadingState());
    DioHelper.postData(
      url: "forums/$forumId/like",
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      if (forumKind == 0) {
        getAllForums();
      } else {
        getMyForums();
      }
      emit(DiscussionForumLikeSuccessState());
    });
  }

  void createPost({required String title, required String description}) {
    emit(DiscussionForumCreatePostLoadingState());
    DioHelper.postData(
      url: EndPoints.CREATE_POST,
      data: {
        "title": title,
        "description": description,
        "imageBase64": _base64Image,
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      Fluttertoast.showToast(
        msg: "Your Post Uploaded Successfully",
        backgroundColor: Colors.green,
      );
      uploadedPostImage = null;
      emit(DiscussionForumCreatePostSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(DiscussionForumCreatePostErrorState());
    });
  }

  String _base64Image = "";
  ImagePicker imagePicker = ImagePicker();
  File? uploadedPostImage;
  Future<void> pickPostImage() async {
    imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        uploadedPostImage = File(value.path);
        Uint8List bytes = uploadedPostImage!.readAsBytesSync();
        _base64Image = base64.encode(bytes);
        _base64Image =
            "data:image/${value.name.split('.').last};base64,$_base64Image";
      }
      emit(DiscussionForumPickImageState());
    });
  }
}
