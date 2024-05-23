import 'package:movie_ticker_app_flutter/data/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';

class SearchMovie {
  late List<Movie> allMovies;
  late List<Movie> filteredMovies;

  SearchMovie() {
    allMovies = TempDB.movies;
    filteredMovies = allMovies;
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredMovies = allMovies;
    } else {
      filteredMovies = allMovies
          .where((movie) =>
              movie.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
