import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/models/user.dart';

class Ticket {
  final int id;
  final List<Seat> seats;
  final User user;

  Ticket({
    required this.id,
    required this.seats,
    required this.user,
  });
}