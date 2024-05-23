import 'package:movie_ticker_app_flutter/models/membership.dart';

class User {
  final int id;
  final String email;
  final String role;
  final String name;
  final String password;
  final String phone;
  final int totalSpending;
  final Membership membership;

  User({
    required this.id,
    required this.email,
    required this.role,
    required this.name,
    required this.password,
    required this.phone,
    required this.totalSpending,
    required this.membership,
  });
}
