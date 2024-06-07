import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/movie_detail_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkerBackground,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 20, color: Colors.white60)));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final names = provider.movies.map((movie) => movie.title).toList();
    List<String> matchQuery = [];
    for (var name in names) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            final selectedMovie = provider.movies.firstWhere(
              (movie) => movie.title == result,
            );
            provider.selectMovie(selectedMovie);
            Navigator.pushNamed(context, MovieDetailPage.routeName);
          },
          child: ListTile(
            title: Text(
              result,
              style: const TextStyle(color: AppColors.grey),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: false);
    final names = provider.movies.map((movie) => movie.title).toList();
    List<String> matchQuery = [];
    for (var name in names) {
      if (name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            final selectedMovie = provider.movies.firstWhere(
              (movie) => movie.title == result,
            );
            provider.selectMovie(selectedMovie);
            Navigator.pushNamed(context, MovieDetailPage.routeName);
          },
          child: ListTile(
            title: Text(
              result,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        );
      },
    );
  }
}
