import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/survei/data/data_sources/remote/survei_api_service.dart';
import 'package:synapsis_challenge/features/survei/data/models/survei.dart';
import 'package:synapsis_challenge/features/survei/domain/repository/survei_repository.dart';

class SurveiRepositoryImpl implements SurveiRepository {
  final SurveiApiService surveiApiService;

  SurveiRepositoryImpl({required this.surveiApiService});
  @override
  Future<DataState<List<SurveiModel>>> getSurvei() async {
    final response = await surveiApiService.getSurvei();
    return response;
  }
}
