import 'package:dio/dio.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/resources/request.dart';
import 'package:synapsis_challenge/features/survei-detail/data/models/survei_detail.dart';
import 'package:synapsis_challenge/features/survei-detail/domain/entity/survei_detail.dart';
import 'package:synapsis_challenge/injection_container.dart';

abstract class SurveiDetailApiService {
  Future<DataState<SurveiDetailEntity>> getSurveiDetail(String id);
  factory SurveiDetailApiService() {
    return SurveiDetailApiServiceImpl();
  }
}

class SurveiDetailApiServiceImpl implements SurveiDetailApiService {
  final request = sl<Request>();
  @override
  Future<DataState<SurveiDetailEntity>> getSurveiDetail(String id) async {
    try {
      final response = await request.dio.get('/survey/$id');
      if (response.statusCode == 200) {
        return DataSuccess(SurveiDetailModel.fromJson(response.data['data']));
      } else {
        return DataError(DioException(
            requestOptions: response.requestOptions,
            error: response.statusMessage,
            response: response));
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }
}
