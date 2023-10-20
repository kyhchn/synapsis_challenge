import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/injection_container.dart';
import 'package:synapsis_challenge/services/user_cache_services.dart';

class RemoveUserCacheUseCase implements UseCase<void, void> {
  @override
  Future<void> call({void params}) async {
    final user = sl<UserCacheService>().getUser();
    if (user != null) {
      await sl<UserCacheService>().deleteUser();
    }
  }
}
