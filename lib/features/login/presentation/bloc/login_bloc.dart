import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/login/domain/entities/user.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/check_user_cache.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/remove_user_cache.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/user_login.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/write_user_cache.dart';
import 'package:synapsis_challenge/features/survei/presentation/bloc/survei_bloc.dart';
import 'package:synapsis_challenge/injection_container.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase userLoginUseCase;
  final CheckUserCacheUseCase checkUserCacheUseCase;
  final RemoveUserCacheUseCase removeUserCacheUseCase;
  final WriteUserCacheUseCase writeUserCache;
  final homeBloc = sl<SurveiBloc>();
  LoginBloc(this.userLoginUseCase, this.checkUserCacheUseCase,
      this.removeUserCacheUseCase, this.writeUserCache)
      : super(LoginInitial()) {
    on<CheckLocalUser>((event, emit) async {
      emit(LoginLoading());
      final user = await sl<CheckUserCacheUseCase>().call();
      if (user != null) {
        homeBloc.add(UserIn(user: user));
        emit(LoginSuccess(user));
      } else {
        emit(LoginInitial());
      }
    });
    on<Login>(onLogin);

    on<Logout>((event, emit) async {
      await sl<RemoveUserCacheUseCase>().call();
      emit(LogoutSuccess());
    });
  }

  void onLogin(Login event, Emitter<LoginState> emit) async {
    final UserModel user =
        UserModel(email: event.email, password: event.password);
    emit(LoginLoading());
    final response = await userLoginUseCase(params: user);

    if (response is DataSuccess && response.data != null) {
      if (event.isRemember) {
        await sl<WriteUserCacheUseCase>().call(params: response.data!);
      }
      homeBloc.add(UserIn(user: response.data!));
      emit(LoginSuccess(response.data!));
    }

    if (response is DataError) {
      emit(LoginError(response.exception!));
    }
  }
}
