import 'package:movie_ticker_app_flutter/models/auditorium.dart';

class Screening {
  final int id;
  final String start;
  final String date;
  final List<Auditorium> auditoriums;

  Screening(
      {required this.id,
      required this.start,
      required this.date,
      required this.auditoriums});
}
