import 'package:movie_ticker_app_flutter/models/cinema.dart';

class Auditorium {
  final int id;
  final String name;
  final Cinema cinema;

  Auditorium({
    required this.id,
    required this.name,
    required this.cinema,
  });
}
