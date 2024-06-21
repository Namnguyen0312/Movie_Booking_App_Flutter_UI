import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/request/create_user_request.dart';
import 'package:movie_ticker_app_flutter/models/request/login_user_request.dart';
import 'package:movie_ticker_app_flutter/models/response/province_district_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_ward_response.dart';
import 'package:movie_ticker_app_flutter/models/response/user_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  String? _token;
  String? get token => _token;

  List<ProvinceResponse>? _province;
  List<ProvinceResponse>? get province => _province;

  List<ProvinceDistrictResponse>? _district;
  List<ProvinceDistrictResponse>? get district => _district;

  List<ProvinceWardResponse>? _ward;
  List<ProvinceWardResponse>? get ward => _ward;

  UserResponse? _user;
  UserResponse? get user => _user;

  String? _email;
  String? get email => _email;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Widget? _widget;
  Widget? get widget => _widget;

  UserProvider() {
    _loadUserData();
  }

  Future<void> getAllProvince() async {
    try {
      _province = await ApiService().getAllProvince();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllDistrictByProvinceId(String provinceId) async {
    try {
      _district = await ApiService().getAllDistrictByProvinceId(provinceId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getAllWardByDistrictId(String districtId) async {
    try {
      _ward = await ApiService().getAllWardByDistrictId(districtId);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyEmail(String email) async {
    try {
      _email = email;
      await ApiService().verifyMail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyOtp(int otp, String email) async {
    try {
      await ApiService().verifyOtp(otp, email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> changePassword(String email, String password) async {
    try {
      await ApiService().changePassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

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
      await _saveUserData();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    _token = null;
    _user = null;
    _isLoggedIn = false;
    await _removeUserData();
    notifyListeners();
  }

  void selectWidget(Widget widget) {
    _widget = widget;
  }

  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_token != null) {
      await prefs.setString('user_token', _token!);
    }
    if (_user != null) {
      await prefs.setString('user_data', json.encode(_user!.toJson()));
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    final userData = prefs.getString('user_data');
    if (token != null && userData != null) {
      _token = token;
      _user = UserResponse.fromJson(json.decode(userData));
      _isLoggedIn = true;
      notifyListeners();
    }
  }

  Future<void> _removeUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_token');
    await prefs.remove('user_data');
  }
}
