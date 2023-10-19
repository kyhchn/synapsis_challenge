part of 'survei_detail_bloc.dart';

sealed class SurveiDetailState extends Equatable {
  const SurveiDetailState();

  @override
  List<Object> get props => [];
}

final class SurveiDetailInitial extends SurveiDetailState {}

final class SurveiDetailLoading extends SurveiDetailState {}

final class SurveiDetailLoaded extends SurveiDetailState {
  final SurveiDetailEntity surveiDetail;
  final UserAnswerEntity userAnswerEntity;

  const SurveiDetailLoaded(
      {required this.surveiDetail, required this.userAnswerEntity});

  @override
  List<Object> get props => [surveiDetail];
}

final class SurveiDetailError extends SurveiDetailState {
  final String message;

  const SurveiDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
