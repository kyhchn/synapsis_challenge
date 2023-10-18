import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/login/domain/entities/user.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> login(String email, String password);
}
