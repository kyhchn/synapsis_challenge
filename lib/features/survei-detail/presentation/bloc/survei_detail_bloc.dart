import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/user_answer.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/usecases/get_survei_detail.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'survei_detail_event.dart';
part 'survei_detail_state.dart';

class SurveiDetailBloc extends Bloc<SurveiDetailEvent, SurveiDetailState> {
  SurveiDetailBloc() : super(SurveiDetailInitial()) {
    on<LoadDetailEvent>((event, emit) async {
      try {
        emit(SurveiDetailLoading());
        final survei =
            await sl<GetSurveiDetailUseCase>().call(params: event.id);
        List<Answer> answers = [];
        survei.data!.questions.forEach((element) {
          answers.add(Answer(questionId: element.id));
        });
        emit(SurveiDetailLoaded(
            surveiDetail: survei.data!,
            userAnswerEntity:
                UserAnswerEntity(surveyId: survei.data!.id, answers: answers)));
      } catch (e) {
        emit(SurveiDetailError(message: e.toString()));
      }
    });
  }
}
