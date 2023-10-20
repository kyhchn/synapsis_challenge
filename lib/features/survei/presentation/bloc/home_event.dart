part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class UserIn extends HomeEvent {
  final UserModel user;

  const UserIn({required this.user});
}
