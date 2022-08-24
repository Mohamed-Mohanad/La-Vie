part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}
class GetUserDataLoadingState extends UserState {}
class GetUserDataSuccessfulState extends UserState {}
class GetUserDataErrorState extends UserState {}
class UploadImageSuccessful extends UserState {}
class UpdateProfilePictureLoadingState extends UserState {}
class UpdateProfilePictureSuccessfulState extends UserState {}
class UpdateProfilePictureErrorState extends UserState {}
class UpdateUserDataLoadingState extends UserState {}
class UpdateUserDataSuccessfulState extends UserState {}
class UpdateUserDataErrorState extends UserState {
  String message;
  UpdateUserDataErrorState({required this.message});
}