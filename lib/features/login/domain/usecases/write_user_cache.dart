import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/injection_container.dart';
import 'package:synapsis_challenge/services/user_cache_services.dart';

class WriteUserCacheUseCase extends UseCase<void, UserModel> {
  @override
  Future<void> call({required UserModel params}) {
    return sl<UserCacheService>().saveUser(params);
  }
}
