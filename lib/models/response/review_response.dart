import 'package:movie_ticker_app_flutter/models/response/user_response.dart';

class ReviewResponse {
  final int id;
  final String date;
  final int numberStar;
  final String content;
  final UserResponse user;

  ReviewResponse({
    required this.id,
    required this.date,
    required this.numberStar,
    required this.content,
    required this.user,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      id: json['id'],
      date: json['date'],
      numberStar: json['numberStar'],
      content: json['content'],
      user: UserResponse.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'numberStar': numberStar,
      'content': content,
      'user': user.toJson(),
    };
  }
}
