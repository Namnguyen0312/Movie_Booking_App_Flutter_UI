import 'package:movie_ticker_app_flutter/models/movie.dart';

import 'auditorium.dart';

class Screening {
  final int id;
  final String start;
  final String date;
  final Auditorium auditorium;
  final Movie movie;

  Screening({
    required this.id,
    required this.start,
    required this.date,
    required this.auditorium,
    required this.movie,
  });

  factory Screening.fromJson(Map<String, dynamic> json) {
    return Screening(
      id: json['id'],
      start: json['start'],
      date: json['date'],
      auditorium: Auditorium.fromJson(json['auditorium']),
      movie: Movie.fromJson(json['movie']),
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
