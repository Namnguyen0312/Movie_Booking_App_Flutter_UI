import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/create_user.dart';
import 'package:movie_ticker_app_flutter/models/login_user.dart';
import 'package:movie_ticker_app_flutter/models/user.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  String? get token => _token;
  User? _user;
  User? get user => _user;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> createUser(UserCreationRequest user) async {
    try {
      await ApiService().createUser(user);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> loginUser(UserLoginRequest user) async {
    try {
      final response = await ApiService().loginUser(user);
      _token = response.token;
      _user = response.user;
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    _token = null;
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
