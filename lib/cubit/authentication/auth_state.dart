part of 'auth_cubit.dart';

@immutable
abstract class AuthenticationState {}

class LoginInitial extends AuthenticationState {}
class ChangeCurrentTabBarItem extends AuthenticationState {}
class CreateUserLoadingState extends AuthenticationState {}
class CreateUserSuccessfulState extends AuthenticationState {}
class CreateUserErrorState extends AuthenticationState {
  String? message;
  CreateUserErrorState({this.message});
}
class LoginLoadingState extends AuthenticationState {}
class LoginSuccessfulState extends AuthenticationState {}
class LoginErrorState extends AuthenticationState {
  String? message;
  LoginErrorState({this.message});
}