part of 'survei_detail_bloc.dart';

sealed class SurveiDetailEvent extends Equatable {
  const SurveiDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDetailEvent extends SurveiDetailEvent {
  final String id;

  const LoadDetailEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AnswerQuestionEvent extends SurveiDetailEvent {
  final String questionId;
  final int answer;

  const AnswerQuestionEvent({required this.questionId, required this.answer});

  @override
  List<Object> get props => [questionId, answer];
}

class SubmitAnswerEvent extends SurveiDetailEvent {
  final UserAnswerEntity userAnswerEntity;

  const SubmitAnswerEvent({required this.userAnswerEntity});

  @override
  List<Object> get props => [userAnswerEntity];
}

class NextQuestionEvent extends SurveiDetailEvent {}

class PreviousQuestionEvent extends SurveiDetailEvent {}

class NavigateQuestionEvent extends SurveiDetailEvent {
  final int index;

  const NavigateQuestionEvent({required this.index});

  @override
  List<Object> get props => [index];
}
