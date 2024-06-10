import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';

import 'auditorium_response.dart';

class ScreeningResponse {
  final int id;
  final String start;
  final String date;
  final AuditoriumResponse auditorium;
  final MovieResponse movie;

  ScreeningResponse({
    required this.id,
    required this.start,
    required this.date,
    required this.auditorium,
    required this.movie,
  });

  factory ScreeningResponse.fromJson(Map<String, dynamic> json) {
    return ScreeningResponse(
      id: json['id'],
      start: json['start'],
      date: json['date'],
      auditorium: AuditoriumResponse.fromJson(json['auditorium']),
      movie: MovieResponse.fromJson(json['movie']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start': start,
      'date': date,
      'auditorium': auditorium.toJson(),
      'movie': movie.toJson(),
    };
  }
}
