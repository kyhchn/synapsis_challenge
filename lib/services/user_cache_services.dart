import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_challenge/features/login/data/models/user.dart';
import 'package:synapsis_challenge/injection_container.dart';

class UserCacheService {
  UserModel? _user;

  UserModel? get user => _user;
  SharedPreferences get sharedPrefs => sl<SharedPreferences>();

  Future<void> saveUser(UserModel user) async {
    _user = user;
    await sharedPrefs.setString('user', jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userString = sharedPrefs.getString('user');
    if (userString != null) {
      _user = UserModel.fromJson(jsonDecode(userString));
      return _user;
    }
    return null;
  }

  Future<void> deleteUser() async {
    _user = null;
    await sharedPrefs.remove('user');
  }
}
