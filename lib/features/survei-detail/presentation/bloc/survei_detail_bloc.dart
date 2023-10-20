
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
        for (var element in survei.data!.questions) {
          answers.add(Answer(questionId: element.id));
        }
        emit(SurveiDetailLoaded(
            surveiDetail: survei.data!,
            index: 0,
            userAnswerEntity: UserAnswerEntity(
              surveyId: survei.data!.id,
              answers: answers,
            )));
      } catch (e) {
        emit(SurveiDetailError(message: e.toString()));
      }
    });

    on<NextQuestionEvent>((event, emit) {
      if (state is SurveiDetailLoaded) {
        SurveiDetailLoaded currentState = state as SurveiDetailLoaded;
        if (currentState.index < currentState.totalQuestion - 1) {
          emit(SurveiDetailLoaded(
              surveiDetail: currentState.surveiDetail,
              userAnswerEntity: currentState.userAnswerEntity,
              index: currentState.index + 1));
        }
      }
    });

    on<PreviousQuestionEvent>((event, emit) {
      if (state is SurveiDetailLoaded) {
        SurveiDetailLoaded currentState = state as SurveiDetailLoaded;
        if (currentState.index > 0) {
          emit(SurveiDetailLoaded(
              surveiDetail: currentState.surveiDetail,
              userAnswerEntity: currentState.userAnswerEntity,
              index: currentState.index - 1));
        }
      }
    });

    on<AnswerQuestionEvent>((event, emit) {
      if (state is SurveiDetailLoaded) {
        SurveiDetailLoaded currentState = state as SurveiDetailLoaded;
        List<Answer> answers = currentState.userAnswerEntity.answers;
        if (event.answer == 0) {
          answers[currentState.index] =
              Answer(questionId: event.questionId, answer: null);
        } else {
          answers[currentState.index] =
              Answer(questionId: event.questionId, answer: event.answer);
        }
        emit(SurveiDetailLoaded(
            surveiDetail: currentState.surveiDetail,
            userAnswerEntity: UserAnswerEntity(
              surveyId: currentState.userAnswerEntity.surveyId,
              answers: answers,
            ),
            index: currentState.index));
      }
    });

    on<NavigateQuestionEvent>((event, emit) {
      if (state is SurveiDetailLoaded) {
        SurveiDetailLoaded currentState = state as SurveiDetailLoaded;
        emit(SurveiDetailLoaded(
            surveiDetail: currentState.surveiDetail,
            userAnswerEntity: currentState.userAnswerEntity,
            index: event.index));
      }
    });
  }
}
