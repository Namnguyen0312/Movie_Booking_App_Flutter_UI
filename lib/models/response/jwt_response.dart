import 'package:movie_ticker_app_flutter/models/response/user_response.dart';

class JwtResponse {
  final String token;
  final UserResponse user;

  JwtResponse({required this.token, required this.user});

  factory JwtResponse.fromJson(Map<String, dynamic> json) {
    return JwtResponse(
      token: json['token'],
      user: UserResponse.fromJson(json['user']),
    );
  }
}
