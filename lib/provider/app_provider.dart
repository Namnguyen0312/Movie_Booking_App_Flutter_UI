import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/models/response/address_response.dart';
import 'package:movie_ticker_app_flutter/models/response/cinema_response.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/models/response/screening_response.dart';
import 'package:movie_ticker_app_flutter/services/api_service.dart';

class AppProvider extends ChangeNotifier {
  String? _selectedCity;
  String? get selectedCity => _selectedCity;

  bool _citySelected = false;
  bool get citySelected => _citySelected;

  List<bool> _isSelected = [];
  List<bool> get isSelected => _isSelected;

  DateTime? _selectedDate;
  DateTime? get selectedDate => _selectedDate;

  bool _dateSelected = false;
  bool get dateSelected => _dateSelected;

  ScreeningResponse? _selectedScreening;
  ScreeningResponse? get selectedScreening => _selectedScreening;

  List<ScreeningResponse> _screenings = [];
  List<ScreeningResponse> get screenings => _screenings;

  final List<DateTime> _days = [];
  List<DateTime> get days => _days;

  List<MovieResponse> _movies = [];
  List<MovieResponse> get movies => _movies;

  List<MovieResponse> _currentMovies = [];
  List<MovieResponse> get currentMovies => _currentMovies;

  List<MovieResponse> _commingSoonMovies = [];
  List<MovieResponse> get commingSoonMovies => _commingSoonMovies;

  MovieResponse? _selectedMovie;
  MovieResponse? get selectedMovie => _selectedMovie;

  List<String> _citys = [];
  List<String> get citys => _citys;

  List<CinemaResponse> _cinemas = [];
  List<CinemaResponse> get cinemas => _cinemas;

  CinemaResponse? _selectedCinema;
  CinemaResponse? get selectedCinema => _selectedCinema;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isCityLoading = false;
  bool get isCityLoading => _isCityLoading;

  Widget? _widget;
  Widget? get widget => _widget;

  bool _isComingSoon = false;
  bool get isComingSoon => _isComingSoon;

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
    _isCityLoading = true;
    notifyListeners();
    try {
      final List<AddressResponse> addresses =
          await ApiService().getAllAddress();
      Set<String> citySet = addresses.map((address) => address.city).toSet();
      _citys = citySet.toList();
    } catch (error) {
      rethrow;
    } finally {
      _isCityLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMovies() async {
    try {
      _movies = await ApiService().getAllMovie();
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

  void checkComingSoon(MovieResponse movie) {
    final dateNow = DateTime.now();
    final releaseDate = DateTime.parse(movie.releaseDate);
    if (dateNow.isBefore(releaseDate) == true) {
      _isComingSoon = true;
    } else {
      _isComingSoon = false;
    }
    print(_isComingSoon);
  }

  void classifyMovie() {
    final dateNow = DateTime.now();
    _commingSoonMovies = _movies.where((movie) {
      final releaseDate = DateTime.parse(movie.releaseDate);
      return dateNow.isBefore(releaseDate);
    }).toList();
    _currentMovies = _movies.where((movie) {
      final releaseDate = DateTime.parse(movie.releaseDate);
      final endDate = DateTime.parse(movie.endDate);
      return dateNow.isAfter(releaseDate) && dateNow.isBefore(endDate);
    }).toList();
  }

  void selectWidget(Widget widget) {
    _widget = widget;
  }

  void onMovieChanged(MovieResponse movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  void reset() {
    _selectedCity = '';
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
    _dateSelected = false;
    _selectedDate = null;
    _selectedScreening = null;
    _screenings = [];
    _isSelected = List<bool>.generate(days.length, (index) => false);
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

  void selectScreening(ScreeningResponse screening) {
    _selectedScreening = screening;
    notifyListeners();
  }

  void selectCinema(CinemaResponse cinema) {
    _selectedCinema = cinema;
    notifyListeners();
  }

  void checkAndSetSelectCinema() {
    _selectedCinema = _selectedScreening!.auditorium.cinema;
    notifyListeners();
  }

  void selectMovie(MovieResponse movie) {
    _selectedMovie = movie;
    notifyListeners();
  }

  Map<String, List<ScreeningResponse>> get screeningsByCinema {
    Map<String, List<ScreeningResponse>> groupedScreenings = {};
    for (var screening in _screenings) {
      final cinemaName = screening.auditorium.cinema.name;
      if (!groupedScreenings.containsKey(cinemaName)) {
        groupedScreenings[cinemaName] = [];
      }
      groupedScreenings[cinemaName]!.add(screening);
    }
    return groupedScreenings;
  }

  Map<String, List<ScreeningResponse>> get screeningsByMovie {
    Map<String, List<ScreeningResponse>> groupedScreenings = {};
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
