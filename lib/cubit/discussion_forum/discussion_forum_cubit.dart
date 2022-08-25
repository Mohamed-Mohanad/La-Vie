import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie_app/core/enum/forum_type.dart';
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

  List<ForumModel> allForums = [];
  void getAllForums() {
    allForums.clear();
    emit(DiscussionForumGetAllForumsLoadingState());
    DioHelper.getData(
      url: EndPoints.ALL_FORUMS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      for (var element in value.data['data']) {
        allForums.add(ForumModel.fromJson(element));
      }
      emit(DiscussionForumGetAllForumsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DiscussionForumGetAllForumsErrorState());
    });
  }

  List<ForumModel> myForums = [];
  void getMyForums() {
    myForums.clear();
    emit(DiscussionForumGetMyForumsLoadingState());
    DioHelper.getData(
      url: EndPoints.MY_FORUMS,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      for (var element in value.data['data']) {
        myForums.add(ForumModel.fromJson(element));
      }
      emit(DiscussionForumGetMyForumsSuccessState());
    }).catchError((error) {
      emit(DiscussionForumGetMyForumsErrorState());
    });
  }

  List<ForumModel> searchForums = [];
  void getSearchForums(String word) {
    emit(DiscussionForumSearchLoadingState());
    searchForums.clear();
    for (var element in allForums) {
      if (element.title!.contains(word)) {
        searchForums.add(element);
      }
    }
    emit(DiscussionForumSearchSuccessState());
  }

  ForumModel? forumModel;
  void getForumById(String id) {
    emit(DiscussionForumGetForumByIdLoadingState());
    DioHelper.getData(
      url: EndPoints.ALL_FORUMS + '/'+id,
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      forumModel = ForumModel.fromJson(value.data['data']);
      emit(DiscussionForumGetForumByIdSuccessState());
    }).catchError((error){

      emit(DiscussionForumGetForumByIdErrorState());
    });
  }

  void likeForum(
    String forumId,
    ForumType forumType,
    int index,
    ForumModel forumModel,
  ) {
    emit(DiscussionForumLikeLoadingState());
    DioHelper.postData(
      url: "forums/$forumId/like",
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      if (forumType == ForumType.All) {
        if (checkIfUserLikedPost(forumModel)) {
          allForums[index].forumLikes!.removeWhere((element) =>
              element.userId == CacheKeysManger.getUserIdFromCache());
        } else {
          allForums[index].forumLikes!.add(ForumLikes(
              forumId: forumId, userId: CacheKeysManger.getUserIdFromCache()));
        }
      } else if (forumType == ForumType.My) {
        if (checkIfUserLikedPost(forumModel)) {
          myForums[index].forumLikes!.removeWhere((element) =>
              element.userId == CacheKeysManger.getUserIdFromCache());
        } else {
          myForums[index].forumLikes!.add(ForumLikes(
              forumId: forumId, userId: CacheKeysManger.getUserIdFromCache()));
        }
      } else {
        if (checkIfUserLikedPost(forumModel)) {
          searchForums[index].forumLikes!.removeWhere((element) =>
              element.userId == CacheKeysManger.getUserIdFromCache());
        } else {
          searchForums[index].forumLikes!.add(ForumLikes(
              forumId: forumId, userId: CacheKeysManger.getUserIdFromCache()));
        }
      }
      emit(DiscussionForumLikeSuccessState());
    });
  }

  void commentForum(
      String forumId, String comment, ForumType forumType, int index) {
    emit(DiscussionForumCommentLoadingState());
    DioHelper.postData(
      url: "forums/$forumId/comment",
      data: {
        "comment": comment,
      },
      token: CacheKeysManger.getUserTokenFromCache(),
    ).then((value) {
      if (forumType == ForumType.All) {
        allForums[index].forumComments!.add(ForumComments(
              forumId: forumId,
              userId: CacheKeysManger.getUserIdFromCache(),
              comment: comment,
              forumCommentId: 'dfs662',
            ));
      } else if (forumType == ForumType.My) {
        myForums[index].forumComments!.add(ForumComments(
              forumId: forumId,
              userId: CacheKeysManger.getUserIdFromCache(),
              comment: comment,
              forumCommentId: 'dfs662',
            ));
      } else {
        searchForums[index].forumComments!.add(ForumComments(
              forumId: forumId,
              userId: CacheKeysManger.getUserIdFromCache(),
              comment: comment,
              forumCommentId: 'dfs662',
            ));
      }
      Fluttertoast.showToast(
        msg: "Your Comment Submitted Successfully",
        backgroundColor: Colors.green,
      );
      emit(DiscussionForumCommentSuccessState());
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
      getAllForums();
      getMyForums();
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

  bool checkIfUserLikedPost(ForumModel forumModel) {
    for (var element in forumModel.forumLikes!) {
      if (element.userId == CacheKeysManger.getUserIdFromCache()) {
        emit(state);
        return true;
      }
    }
    emit(state);
    return false;
  }
}
