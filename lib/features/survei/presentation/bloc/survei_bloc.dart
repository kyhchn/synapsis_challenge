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
      print(event.user.token!);
      emit(SurveiLoading());
      sl<Request>().setToken(event.user.token!);
      final survei = await sl<GetSurveiUseCase>().call();
      if (survei is DataSuccess && survei.data != null) {
        print('emitting');
        emit(SurveiLoaded(surveis: survei.data!));
      } else {
        print('error');
      }
    });
  }
}
