import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/domain/repository/survei_repository.dart';

class GetSurveiUseCase implements UseCase<DataState<List<SurveiEntity>>, void> {
  final SurveiRepository surveiRepository;

  GetSurveiUseCase({required this.surveiRepository});
  @override
  Future<DataState<List<SurveiEntity>>> call({void params}) async {
    final surveis = await surveiRepository.getSurvei();
    return surveis;
  }
}
