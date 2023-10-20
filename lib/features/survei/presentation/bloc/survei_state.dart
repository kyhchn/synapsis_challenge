part of 'survei_bloc.dart';

sealed class SurveiState extends Equatable {
  final List<SurveiEntity>? surveis;
  const SurveiState({this.surveis});

  @override
  List<Object> get props => [];
}

final class SurveiInitial extends SurveiState {}

final class SurveiLoading extends SurveiState {}

final class SurveiLoaded extends SurveiState {
  const SurveiLoaded({required List<SurveiEntity> surveis})
      : super(surveis: surveis);
}

final class SurveiError extends SurveiState {
  final String message;
  const SurveiError({required this.message});
}
