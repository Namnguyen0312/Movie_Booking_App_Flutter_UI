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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      role: json['role'],
      name: json['name'],
      password: json['password'],
      phone: json['phone'],
      totalSpending: json['totalSpending'],
      membership: json['membership'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'name': name,
      'password': password,
      'phone': phone,
      'totalSpending': totalSpending,
      'membership': membership,
    };
  }
}
