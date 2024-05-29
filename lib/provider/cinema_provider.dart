import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';

class CinemaProvider extends ChangeNotifier {
  List<String> _citys = [];
  List<Cinema> _cinemas = [];
  final List<Movie> _movies = [];

  List<String> get citys => _citys;
  List<Cinema> get cinemas => _cinemas;
  List<Movie> get movies => _movies;

  Future<void> getCityToAddress() async {
    // try {
    //   final List<Address> address = await ApiService().getAllAddress();
    //   _citys = address.map((address) => address.city).toList();
    //    notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
    _citys = TempDB.tableAddress.map((address) => address.city).toList();
  }

  Future<void> fetchCinemasByCity(String city) async {
    // try {
    //   _cinemas = await ApiService().getCinemasByCity(city);
    //    notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
    _cinemas = TempDB.tableCinema
        .where((cinema) => cinema.address.city == city)
        .toList();
    notifyListeners();
  }

  Future<void> fetchmMoviesByCinema(int cinemaId) async {
    // try {
    //   _movies = await ApiService().getMoviesByCinema(cinemaId);
    //   notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
    // _movies = TempDB.ta.map((address) => address.city).toList();
  }
}
