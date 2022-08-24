part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class ChangeCurrentTabBarItem extends LoginState {}
class CreateUserLoadingState extends LoginState {}
class CreateUserSuccessfulState extends LoginState {}
class CreateUserErrorState extends LoginState {
  String? message;
  CreateUserErrorState({this.message});
}
class LoginLoadingState extends LoginState {}
class LoginSuccessfulState extends LoginState {}
class LoginErrorState extends LoginState {
  String? message;
  LoginErrorState({this.message});
}