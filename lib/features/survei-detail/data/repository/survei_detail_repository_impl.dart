import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/survei-detail/data/data_sources/survei_detail_api_service.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/repository/survei_detail_repository.dart';

class SurveiDetailRepositoryImpl implements SurveiDetailRepository {
  final SurveiDetailApiService surveiDetailApiService;
  const SurveiDetailRepositoryImpl({required this.surveiDetailApiService});
  @override
  Future<DataState<SurveiDetailEntity>> getSurveiDetail(String id) {
    return surveiDetailApiService.getSurveiDetail(id);
  }
}
