import 'package:dio/dio.dart';
import 'package:synapsis_challenge/core/constants/constants.dart';

class Request {
  final dio = Dio();

  Request() {
    setupDio();
  }

  void setupDio() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  void setToken(String token) {
    dio.options.headers['Cookie'] = 'token=$token';
  }
}
