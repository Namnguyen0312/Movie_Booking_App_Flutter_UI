import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/request/create_user_request.dart';
import 'package:movie_ticker_app_flutter/models/request/login_user_request.dart';
import 'package:movie_ticker_app_flutter/models/response/province_district_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_response.dart';
import 'package:movie_ticker_app_flutter/models/response/province_ward_response.dart';

import 'package:movie_ticker_app_flutter/models/response/user_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

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

  void selectWidget(Widget widget) {
    _widget = widget;
  }
}
