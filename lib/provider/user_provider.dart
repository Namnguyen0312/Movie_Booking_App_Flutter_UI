import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class UserProvider with ChangeNotifier {
  Future<void> createUser(
    String name,
    String email,
    String phone,
    String address,
    String password,
  ) async {
    try {
      await ApiService().createUser(name, email, phone, address, password);
    } catch (e) {
      rethrow;
    }
  }
}
