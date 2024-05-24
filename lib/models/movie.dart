import 'package:movie_ticker_app_flutter/models/genre.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class Movie {
  final int id;
  final String title;
  final int duration;
  final String image;
  final double rating;
  final String endDate;
  final String releaseDate;
  final List<Genre> genres;
  final String description;
  final List<String> director;
  final List<String> casters;
  final List<String> trailers;
  final List<Screening> screenings;

  Movie(
    this.id,
    this.title,
    this.duration,
    this.image,
    this.rating,
    this.endDate,
    this.releaseDate,
    this.genres,
    this.description,
    this.director,
    this.casters,
    this.trailers,
    this.screenings,
  );
}

// Object other

final List<String> days = [
  'SAT',
  'SUN',
  'MON',
  'TUE',
  'WED',
  'THU',
  'FRI',
  'SAT',
  'SUN',
  'MON',
];
final List<String> times = ['12:20', '13:30', '14:30', '19:00'];

enum TicketStates {
  idle,
  active,
  busy,
}

final List<TicketStates> dayStates = [
  TicketStates.active,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
];

final List<TicketStates> dayStates1 = [
  TicketStates.busy,
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.idle,
];

final List<TicketStates> dayStates2 = [
  TicketStates.idle,
  TicketStates.idle,
  TicketStates.busy,
  TicketStates.idle,
];

final List<String> seatRow = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
final List<String> seatNumber = ['1', '2', '3', '4', '5', '6', '7', '8'];
