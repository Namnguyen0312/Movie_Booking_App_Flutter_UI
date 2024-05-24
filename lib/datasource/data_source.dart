import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/auditorium.dart';
import 'package:movie_ticker_app_flutter/models/auth_response_model.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/genre.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/response_model.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/models/ticket.dart';
import 'package:movie_ticker_app_flutter/models/user.dart';

abstract class DataSource {
  Future<AuthResponseModel?> login(User user);
  Future<List<Movie>> getAllMovie();
  Future<List<Address>> getAllAddress();
  Future<List<Cinema>> getCinamaByCity(String city);
  Future<List<Seat>> getSeatByAuditorium(int idAuditorium);
  Future<List<Screening>> getScreeningByCinema(String cinema);
  Future<List<Genre>> getGenre();
  Future<List<Auditorium>> getAllAuditorium();
  Future<ResponseModel> addTicket(Ticket ticket);
}
