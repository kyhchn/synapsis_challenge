import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';

abstract class SurveiDetailRepository {
  Future<DataState<SurveiDetailEntity>> getSurveiDetail(String id);
}
