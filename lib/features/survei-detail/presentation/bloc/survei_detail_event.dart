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
