import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';

class AppProvider extends ChangeNotifier {
  String? _selectedCity;
  DateTime? _selectedDate;
  Screening? _selectedScreening;
  List<Screening> _screenings = [];
  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String? get selectedCity => _selectedCity;
  DateTime? get selectedDate => _selectedDate;
  List<Screening> get screenings => _screenings;

  Screening? get selectedScreening => _selectedScreening;

  void selectScreening(Screening screening) {
    _selectedScreening = screening;
    notifyListeners();
  }

  void clearSelection() {
    _selectedScreening = null;
    notifyListeners();
  }

  Future<void> fetchMovies() async {
    // final response = await http.get(Uri.parse('http://your-api-url/api/movies'));
    // if (response.statusCode == 200) {
    //   List<dynamic> data = json.decode(response.body);
    //   _movies = data.map((json) => Movie.fromJson(json)).toList();
    //   notifyListeners();
    // } else {
    //   throw Exception('Failed to load movies');
    // }
    _movies = TempDB.movies;
  }

  void reset() {
    _screenings = [];
    notifyListeners();
  }

  void selectCity(String city, Movie movie) {
    _selectedCity = city;
    clearSelection();
    notifyListeners();
  }

  void selectDate(DateTime date) {
    _selectedDate = date;
    clearSelection();
    notifyListeners();
  }

  Future<void> getScreeningsByMovieAndCity(
    Movie movie,
    String city,
    DateTime dateTime,
  ) async {
    // try {
    //   final List<Screening> screenings =
    //       await ApiService().getScreeningsByMovieAndCity(city, movieId);

    //   _screenings = screenings.where(
    //     (screening) {
    //       final screeningDate = DateTime.parse(screening.date);
    //       return screeningDate.year == dateTime.year &&
    //           screeningDate.month == dateTime.month &&
    //           screeningDate.day == dateTime.day;
    //     },
    //   ).toList();
    //   notifyListeners();
    // } catch (error) {
    //   rethrow;
    // }
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

  // void _filterScreenings(Movie movie) {
  //   if (_selectedCity == null || _selectedDate == null) return;

  //   _filteredScreenings = movie.screenings.where((screening) {
  //     final screeningDate = DateTime.parse(screening.date);
  //     return screeningDate.year == _selectedDate!.year &&
  //         screeningDate.month == _selectedDate!.month &&
  //         screeningDate.day == _selectedDate!.day &&
  //         screening.auditorium.cinema.address.city == _selectedCity;
  //   }).toList();

  //   _filteredScreenings.sort((a, b) {
  //     final format = DateFormat("yyyy-MM-dd HH:mm");
  //     final timeA = format.parse('${a.date} ${a.start}');
  //     final timeB = format.parse('${b.date} ${b.start}');
  //     return timeA.compareTo(timeB);
  //   });
  // }

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
