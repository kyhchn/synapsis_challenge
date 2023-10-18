part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SurveiRequested extends HomeEvent {}

class Logout extends HomeEvent {}

class CheckUser extends HomeEvent {}
