import 'package:movie_ticker_app_flutter/models/movie.dart';

class Screening {
  final int id;
  final String start;
  final String date;
  final List<Movie> movies;

  Screening(
      {required this.id,
      required this.start,
      required this.date,
      required this.movies});
}
