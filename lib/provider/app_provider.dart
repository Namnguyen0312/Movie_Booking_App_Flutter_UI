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

  void reset() {
    _selectedCity = '';
    _isSelected = [];
    _citySelected = false;

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
    // screeningsByCinema;
    _selectedCity = city;
    _citySelected = true;
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    _dateSelected = true;
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
    // notifyListeners();
  }

  void checkAndSetSelectMovie() {
    for (var movie in _movies) {
      if (movie.screenings.contains(_selectedScreening)) {
        _selectedMovie = movie;
        notifyListeners();
        return;
      }
    }
    _selectedMovie = null;
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
    for (var movie in _movies) {
      final movieTitle = movie.title;
      groupedScreenings[movieTitle] = movie.screenings.where(
        (screening) {
          final screeningDate = DateTime.parse(screening.date);
          return _selectedDate != null &&
              screeningDate.year == _selectedDate!.year &&
              screeningDate.month == _selectedDate!.month &&
              screeningDate.day == _selectedDate!.day &&
              screening.auditorium.cinema.name == _selectedCinema!.name;
        },
      ).toList();
    }
    return groupedScreenings;
  }
}
