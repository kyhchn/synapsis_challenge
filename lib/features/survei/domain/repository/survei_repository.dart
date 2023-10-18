import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';

abstract class SurveiRepository {
  Future<DataState<List<SurveiEntity>>> getSurvei();
}
