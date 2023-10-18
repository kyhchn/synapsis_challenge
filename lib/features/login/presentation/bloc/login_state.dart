part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  final UserEntity? user;
  final DioException? exception;
  const LoginState({this.user, this.exception});

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess(UserEntity user) : super(user: user);
}

final class LoginError extends LoginState {
  const LoginError(DioException exception) : super(exception: exception);
}
