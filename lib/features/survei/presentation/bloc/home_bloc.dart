import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/resources/request.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/get_survei.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<UserIn>((event, emit) async {
      print(event.user.token!);
      emit(HomeLoading());
      sl<Request>().setToken(event.user.token!);
      final survei = await sl<GetSurveiUseCase>().call();
      if (survei is DataSuccess && survei.data != null) {
        print('emitting');
        emit(HomeLoaded(surveis: survei.data!));
      } else {
        print('error');
      }
    });
  }
}
