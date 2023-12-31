import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/features/login/domain/repository/user_repository.dart';

class UserLoginUseCase implements UseCase<DataState<UserModel>, UserModel> {
  final UserRepository userRepository;

  UserLoginUseCase({required this.userRepository});

  @override
  Future<DataState<UserModel>> call({required UserModel params}) async {
    final response =
        await userRepository.login(params.email!, params.password!);
    return response;
  }
}
