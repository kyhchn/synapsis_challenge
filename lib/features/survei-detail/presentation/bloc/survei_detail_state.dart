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
  final int index;
  int get totalQuestion => surveiDetail.questions.length;
  int get totalQuestionAnswered => userAnswerEntity.answers
      .where((element) => element.answer != null)
      .length;
  

  const SurveiDetailLoaded(
      {required this.surveiDetail,
      required this.userAnswerEntity,
      required this.index});

  @override
  List<Object> get props => [surveiDetail, userAnswerEntity, index];
}

final class SurveiDetailError extends SurveiDetailState {
  final String message;

  const SurveiDetailError({required this.message});

  @override
  List<Object> get props => [message];
}
