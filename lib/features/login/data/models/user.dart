import 'package:synapsis_challenge/features/login/domain/entities/user.dart';

class UserModel extends UserEntity {
  String? email;
  String? password;
  String? token;

  UserModel(
      {super.occupationLevel,
      super.occupationName,
      this.token,
      this.email,
      this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      occupationLevel: json['occupation_level'],
      occupationName: json['occupation_name'],
      email: json['email']??'',
      password: json['password']??'',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'token': token,
      'occupation_level': occupationLevel,
      'occupation_name': occupationName
    };
  }
}
