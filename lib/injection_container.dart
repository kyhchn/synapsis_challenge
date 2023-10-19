import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_challenge/core/resources/request.dart';
import 'package:synapsis_challenge/features/login/data/data_sources/remote/user_api_service.dart';
import 'package:synapsis_challenge/features/login/data/repository/user_repository_impl.dart';
import 'package:synapsis_challenge/features/login/domain/repository/user_repository.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/check_user_cache.dart';
import 'package:synapsis_challenge/features/login/domain/usecases/user_login.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/survei-detail/data/data_sources/survei_detail_api_service.dart';
import 'package:synapsis_challenge/features/survei-detail/data/repository/survei_detail_repository_impl.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/repository/survei_detail_repository.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/usecases/get_survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei/data/data_sources/remote/survei_api_service.dart';
import 'package:synapsis_challenge/features/survei/data/repository/survei_repository_impl.dart';
import 'package:synapsis_challenge/features/survei/domain/repository/survei_repository.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/get_survei.dart';
import 'package:synapsis_challenge/features/survei/presentation/bloc/home_bloc.dart';
import 'package:synapsis_challenge/services/user_cache_services.dart';
import 'package:synapsis_challenge/features/survei/domain/usecases/check_local_user.dart'
    as checkLocalUser;

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory(() => sharedPreferences);

  sl.registerSingleton<UserCacheService>(UserCacheService());

  sl.registerSingleton<Request>(Request());

  sl.registerSingleton<CheckUserCacheUseCase>(CheckUserCacheUseCase());

  sl.registerSingleton<UserApiService>(UserApiService());

  sl.registerSingleton<UserRepository>(
      UserRepositoryImpl(userApiService: sl()));

  sl.registerSingleton<UserLoginUseCase>(
      UserLoginUseCase(userRepository: sl()));

  sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));

  sl.registerSingleton<checkLocalUser.CheckLocalUser>(
      checkLocalUser.CheckLocalUser());
  sl.registerSingleton<SurveiApiService>(SurveiApiService());

  sl.registerSingleton<SurveiRepository>(
      SurveiRepositoryImpl(surveiApiService: sl()));

  sl.registerSingleton<GetSurveiUseCase>(
      GetSurveiUseCase(surveiRepository: sl()));

  sl.registerFactory<HomeBloc>(() => HomeBloc());
  sl.registerSingleton<SurveiDetailApiService>(SurveiDetailApiService());
  sl.registerSingleton<SurveiDetailRepository>(
      SurveiDetailRepositoryImpl(surveiDetailApiService: sl()));
  sl.registerSingleton<GetSurveiDetailUseCase>(
      GetSurveiDetailUseCase(surveiDetailRepository: sl()));

  sl.registerFactory<SurveiDetailBloc>(() => SurveiDetailBloc());
}
