import 'package:dio/dio.dart';
import 'package:synapsis_challenge/core/resources/data_state.dart';
import 'package:synapsis_challenge/core/resources/request.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/injection_container.dart';

abstract class UserApiService {
  Future<DataState<UserModel>> login({required UserModel user});

  factory UserApiService() {
    return UserApiServiceImpl();
  }
}

class UserApiServiceImpl implements UserApiService {
  final request = sl<Request>();
  @override
  Future<DataState<UserModel>> login({required UserModel user}) async {
    try {
      final response = await request.dio.post('/login', data: {
        'email': user.email,
        'password': user.password,
      });
      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data['data']);
        final token =
            response.headers['set-cookie']![0].split(";")[0].split("=")[1];
        user.token = token;
        return DataSuccess(user);
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
