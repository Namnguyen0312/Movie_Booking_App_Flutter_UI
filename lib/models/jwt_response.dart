import 'package:movie_ticker_app_flutter/models/user.dart';

class JwtResponse {
  final String token;
  final User user;

  JwtResponse({required this.token, required this.user});

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
