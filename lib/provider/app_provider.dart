import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/models/address.dart';
import 'package:movie_ticker_app_flutter/models/cinema.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class AppProvider extends ChangeNotifier {
  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  List<bool> _isSelected = [];
  List<bool> get isSelected => _isSelected;

  bool _citySelected = false;
  bool get citySelected => _citySelected;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  bool _dateSelected = false;
  bool get dateSelected => _dateSelected;

  Screening? _selectedScreening;
  Screening? get selectedScreening => _selectedScreening;

  List<Screening> _screenings = [];
  List<Screening> get screenings => _screenings;

  final List<DateTime> _days = [];
  List<DateTime> get days => _days;

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  Movie? _selectedMovie;
  Movie? get selectedMovie => _selectedMovie;

  List<String> _citys = [];
  List<String> get citys => _citys;

  List<Cinema> _cinemas = [];
  List<Cinema> get cinemas => _cinemas;

  Cinema? _selectedCinema;
  Cinema? get selectedCinema => _selectedCinema;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

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

  Future<void> getCityToAddress() async {
    try {
      final List<Address> addresses = await ApiService().getAllAddress();
      Set<String> citySet = addresses.map((address) => address.city).toSet();
      _citys = citySet.toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchMovies() async {
    try {
      _movies = await ApiService().getAllMovie();
      // notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getScreeningsByMovieAndCity(
    int movieId,
    String city,
    DateTime dateTime,
  ) async {
    try {
      final screenings =
          await ApiService().getScreeningsByMovieAndCity(city, movieId);
      _screenings = screenings.where(
        (screening) {
          final screeningDate = DateTime.parse(screening.date);
          return screeningDate.year == dateTime.year &&
              screeningDate.month == dateTime.month &&
              screeningDate.day == dateTime.day;
        },
      ).toList();
      _screenings.sort((a, b) {
        final format = DateFormat("yyyy-MM-dd HH:mm");
        final timeA = format.parse('${a.date} ${a.start}');
        final timeB = format.parse('${b.date} ${b.start}');
        return timeA.compareTo(timeB);
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchCinemasByCity(String city) async {
    try {
      _isLoading = true;
      _cinemas = await ApiService().getCinemasByCity(city);
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = true;
      rethrow;
    }
  }

  Future<void> getScreeningsByCinema(
    int cinemaId,
    DateTime dateTime,
  ) async {
    try {
      final screenings = await ApiService().getScreeningsByCinema(cinemaId);
      _screenings = screenings.where(
        (screening) {
          final screeningDate = DateTime.parse(screening.date);
          return screeningDate.year == dateTime.year &&
              screeningDate.month == dateTime.month &&
              screeningDate.day == dateTime.day;
        },
      ).toList();
      _screenings.sort((a, b) {
        final format = DateFormat("yyyy-MM-dd HH:mm");
        final timeA = format.parse('${a.date} ${a.start}');
        final timeB = format.parse('${b.date} ${b.start}');
        return timeA.compareTo(timeB);
      });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void reset() {
    _selectedCity = '';
    _isSelected = [];
    _citySelected = false;
    _dateSelected = false;
    _selectedDate = null;
    _selectedScreening = null;
    _screenings = [];
    _cinemas = [];
    _citys = [];

    _isSelected = List<bool>.generate(days.length, (index) => false);
    notifyListeners();
  }

  void resetForCinema() {
    _isSelected = List<bool>.generate(days.length, (index) => false);
    _dateSelected = false;
    _selectedDate = null;
    screeningsByMovie.clear();
    _selectedScreening = null;
    notifyListeners();
  }

  void selectCity(String city) {
    _selectedCity = city;
    _citySelected = true;
    _selectedScreening = null;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _dateSelected = true;
    _selectedScreening = null;
    notifyListeners();
  }

  void selectScreening(Screening screening) {
    _selectedScreening = screening;
    notifyListeners();
  }

  void selectCinema(Cinema cinema) {
    _selectedCinema = cinema;
    notifyListeners();
  }

  void selectMovie(Movie movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  void checkAndSetSelectMovie() {
    _selectedMovie = _selectedScreening!.movie;
    notifyListeners();
  }

  Map<Cinema, List<Screening>> get screeningsByCinema {
    Map<Cinema, List<Screening>> groupedScreenings = {};
    for (var screening in screenings) {
      final cinema = screening.auditorium.cinema;
      if (groupedScreenings.containsKey(cinema)) {
        groupedScreenings[cinema]!.add(screening);
      } else {
        groupedScreenings[cinema] = [screening];
      }
    }
    return groupedScreenings;
  }

  Map<String, List<Screening>> get filteredScreeningsByMovie {
    return Map.fromEntries(
        screeningsByMovie.entries.where((entry) => entry.value.isNotEmpty));
  }

  bool get hasScreenings {
    bool allValuesEmpty =
        screeningsByMovie.values.every((list) => list.isEmpty);
    if (!allValuesEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Map<String, List<Screening>> get screeningsByMovie {
    Map<String, List<Screening>> groupedScreenings = {};
    for (var screening in _screenings) {
      final movieTitle = screening.movie.title;
      if (selectedDate != null) {
        if (!groupedScreenings.containsKey(movieTitle)) {
          groupedScreenings[movieTitle] = [];
        }
        groupedScreenings[movieTitle]!.add(screening);
      }
    }

    return groupedScreenings;
  }
}
