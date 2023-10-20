import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';

abstract class UserRepository {
  Future<DataState<UserModel>> login(String email, String password);
}
