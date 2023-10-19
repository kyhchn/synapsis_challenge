import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/usecase/usecase.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/repository/survei_detail_repository.dart';

class GetSurveiDetailUseCase
    implements UseCase<DataState<SurveiDetailEntity>, String> {
  final SurveiDetailRepository surveiDetailRepository;

  GetSurveiDetailUseCase({required this.surveiDetailRepository});

  @override
  Future<DataState<SurveiDetailEntity>> call({required String params}) {
    return surveiDetailRepository.getSurveiDetail(params);
  }
}
