import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class CinemaProvider extends ChangeNotifier {
  String? _selectedCity;
  DateTime? _selectedDate;
  List<Cinema> _filteredCinemas = [];
  List<Screening> _filteredScreenings = [];

  String? get selectedCity => _selectedCity;
  DateTime? get selectedDate => _selectedDate;
  List<Cinema> get filteredCinemas => _filteredCinemas;
  List<Screening> get filteredScreenings => _filteredScreenings;

  void selectCity(String city, Movie movie) {
    _selectedCity = city;
    _filteredCinemas = TempDB.tableCinema.where((cinema) {
      return cinema.address.city == city;
    }).toList();
    _filterScreenings(movie);
    notifyListeners();
  }

  void selectDate(DateTime date, Movie movie) {
    _selectedDate = date;
    _filterScreenings(movie);
    notifyListeners();
  }

  void _filterScreenings(Movie movie) {
    if (_selectedCity == null || _selectedDate == null) return;

    _filteredScreenings = TempDB.tableScreening.where((screening) {
      final screeningDate = DateTime.parse(screening.date);
      return screeningDate.year == _selectedDate!.year &&
          screeningDate.month == _selectedDate!.month &&
          screeningDate.day == _selectedDate!.day &&
          screening.auditoriums.any(
              (auditorium) => _filteredCinemas.contains(auditorium.cinema)) &&
          movie.screenings
              .any((movieScreening) => movieScreening.id == screening.id);
    }).toList();
  }
}
