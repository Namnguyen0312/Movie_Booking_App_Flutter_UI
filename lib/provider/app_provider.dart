import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class AppProvider extends ChangeNotifier {
  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  List<bool> _isSelected = [];
  List<bool> get isSelected => _isSelected;

  bool _citySelected = false;
  bool get citySelected => _citySelected;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  Screening? _selectedScreening;
  Screening? get selectedScreening => _selectedScreening;

  List<Screening> _screenings = [];
  List<Screening> get screenings => _screenings;

  final List<DateTime> _days = [];
  List<DateTime> get days => _days;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  List<Movie> _moviesByCinema = [];
  List<Movie> get moviesByCinema => _moviesByCinema;

  List<String> _citys = [];
  List<String> get citys => _citys;

  List<Cinema> _cinemas = [];
  List<Cinema> get cinemas => _cinemas;

  AppProvider() {
    generateDays();
  }

  void generateDays() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _days.add(today.add(Duration(days: i)));
    }
  }

  void updateIsSelected(int selectedIndex, List<DateTime> days) {
    _isSelected = List<bool>.generate(
      days.length,
      (index) => index == selectedIndex ? true : false,
    );
    notifyListeners();
  }

  void selectScreening(Screening screening) {
    _selectedScreening = screening;
    notifyListeners();
  }

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

  Future<void> fetchMovies() async {
    // try {
    //   _movies = await ApiService().getAllMovie();
    //    notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
    _movies = TempDB.movies;
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

  Future<void> fetchMoviesByCinema(int cinemaId) async {
    // try {
    //   _movies = await ApiService().getMoviesByCinema(cinemaId);
    //   notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
    // _movies = TempDB.ta.map((address) => address.city).toList();
  }

  void reset() {
    _selectedCity = '';

    _isSelected = [];
    _citySelected = false;

    _selectedDate = null;
    _selectedScreening = null;
    _screenings = [];

    _citys = [];

    _isSelected = List<bool>.generate(days.length, (index) => false);
    notifyListeners();
  }

  void selectCity(String city) {
    // screeningsByCinema;
    _selectedCity = city;
    _citySelected = true;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future<void> getScreeningsByMovieAndCity(
    Movie movie,
    String city,
    DateTime dateTime,
  ) async {
    _screenings = movie.screenings.where(
      (screening) {
        final screeningDate = DateTime.parse(screening.date);
        return screeningDate.year == dateTime.year &&
            screeningDate.month == dateTime.month &&
            screeningDate.day == dateTime.day &&
            screening.auditorium.cinema.address.city == city;
      },
    ).toList();
    _screenings.sort((a, b) {
      final format = DateFormat("yyyy-MM-dd HH:mm");
      final timeA = format.parse('${a.date} ${a.start}');
      final timeB = format.parse('${b.date} ${b.start}');
      return timeA.compareTo(timeB);
    });
    notifyListeners();
  }

  Map<String, List<Screening>> get screeningsByCinema {
    Map<String, List<Screening>> groupedScreenings = {};
    for (var screening in screenings) {
      final cinemaName = screening.auditorium.cinema.name;
      if (groupedScreenings.containsKey(cinemaName)) {
        groupedScreenings[cinemaName]!.add(screening);
      } else {
        groupedScreenings[cinemaName] = [screening];
      }
    }
    return groupedScreenings;
  }
}
