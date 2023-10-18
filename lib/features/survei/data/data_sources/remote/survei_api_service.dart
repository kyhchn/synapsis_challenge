import 'package:dio/dio.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/resources/request.dart';

import 'package:synapsis_challenge/features/survei/data/models/survei.dart';
import 'package:synapsis_challenge/injection_container.dart';

abstract class SurveiApiService {
  Future<DataState<List<SurveiModel>>> getSurvei();
  factory SurveiApiService() {
    return SurveiApiServiceImpl();
  }
}

class SurveiApiServiceImpl implements SurveiApiService {
  final request = sl<Request>();
  @override
  Future<DataState<List<SurveiModel>>> getSurvei() async {
    try {
      final response = await request.dio.get('/survey');
      if (response.statusCode == 200) {
        final survei = (response.data['data'] as List)
            .map((e) => SurveiModel.fromJson(e))
            .toList();
        return DataSuccess(survei);
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
