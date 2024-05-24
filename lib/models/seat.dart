import 'package:movie_ticker_app_flutter/models/auditorium.dart';

class Seat {
  final int id;
  final String numberSeat;
  final int price;
  final Enum status;
  final Auditorium auditorium;

  Seat({
    required this.id,
    required this.numberSeat,
    required this.price,
    required this.status,
    required this.auditorium,
  });
}
