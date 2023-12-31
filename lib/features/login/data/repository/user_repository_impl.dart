import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/login/data/data_sources/remote/user_api_service.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/login/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService userApiService;

  UserRepositoryImpl({required this.userApiService});

  @override
  Future<DataState<UserModel>> login(String email, String password) async {
    final response = await userApiService.login(
        user: UserModel(
      email: email,
      password: password,
    ));
    return response;
  }
}
