import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';

class Auditorium {
  final int id;
  final String name;
  final List<Seat> seats;
  final List<Screening> creenings;

  Auditorium({
    required this.id,
    required this.name,
    required this.seats,
    required this.creenings,
  });
}
