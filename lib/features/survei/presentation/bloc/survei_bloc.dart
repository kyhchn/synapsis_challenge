import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/resources/request.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/get_survei.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'survei_event.dart';
part 'survei_state.dart';

class SurveiBloc extends Bloc<SurveiEvent, SurveiState> {
  SurveiBloc() : super(SurveiInitial()) {
    on<UserIn>((event, emit) async {
      emit(SurveiLoading());
      sl<Request>().setToken(event.user.token!);
      await fetch(emit);
    });

    on<LoadSurvei>((event, emit) async {
      emit(SurveiLoading());
      await fetch(emit);
    });
  }

  Future<void> fetch(Emitter<SurveiState> emit) async {
    final survei = await sl<GetSurveiUseCase>().call();
    if (survei is DataSuccess) {
      if (survei.data != null) {
        emit(SurveiLoaded(surveis: survei.data!));
      } else {
        emit(SurveiEmpty());
      }
    } else if (survei is DataError) {
      emit(SurveiError(message: survei.exception!.message!));
    } else {
      emit(const SurveiError(message: 'Unknown error'));
    }
  }
}
