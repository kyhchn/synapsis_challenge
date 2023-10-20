part of 'survei_bloc.dart';

sealed class SurveiEvent extends Equatable {
  const SurveiEvent();

  @override
  List<Object> get props => [];
}

class UserIn extends SurveiEvent {
  final UserModel user;

  const UserIn({required this.user});
}
