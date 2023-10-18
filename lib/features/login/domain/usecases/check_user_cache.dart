import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/injection_container.dart';
import 'package:synapsis_challenge/services/user_cache_services.dart';

class CheckUserCacheUseCase implements UseCase<UserModel?, void> {
  @override
  Future<UserModel?> call({void params}) async {
    final user = sl<UserCacheService>().getUser();
    return user;
  }
}
