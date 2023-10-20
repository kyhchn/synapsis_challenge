part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CheckLocalUser extends LoginEvent {}

class Login extends LoginEvent {
  final bool isRemember;
  final String email;
  final String password;

  const Login(
      {required this.email, required this.password, this.isRemember = false});
}

class Logout extends LoginEvent {}
