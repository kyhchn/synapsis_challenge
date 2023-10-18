import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/check_local_user.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/get_survei.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<CheckUser>((event, emit) async {
      emit(HomeLoading());
      final user = await sl<CheckLocalUser>().call();
      if (user != null) {
        final surveis = await sl<GetSurveiUseCase>().call();
        emit(HomeLoaded(surveis: surveis.data!));
      } else {
        emit(const HomeError(message: 'User not found'));
      }
    });
  }
}
