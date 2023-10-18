part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final List<SurveiEntity>? surveis;
  const HomeState({this.surveis});

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required List<SurveiEntity> surveis})
      : super(surveis: surveis);
}

final class HomeError extends HomeState {
  final String message;
  const HomeError({required this.message});
}
