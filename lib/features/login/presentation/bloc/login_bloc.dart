import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/login/domain/entities/user.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/check_user_cache.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/user_login.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase userLoginUseCase;

  LoginBloc(this.userLoginUseCase) : super(LoginInitial()) {
    on<CheckLocalUser>((event, emit) async {
      emit(LoginLoading());
      final user = await sl<CheckUserCacheUseCase>().call();
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginInitial());
      }
    });
    on<Login>(onLogin);
  }

  void onLogin(Login event, Emitter<LoginState> emit) async {
    final UserModel user =
        UserModel(email: event.email, password: event.password);
    emit(LoginLoading());
    final response = await userLoginUseCase(params: user);

    if (response is DataSuccess && response.data != null) {
      emit(LoginSuccess(response.data!));
    }

    if (response is DataError) {
      emit(LoginError(response.exception!));
    }
  }
}
