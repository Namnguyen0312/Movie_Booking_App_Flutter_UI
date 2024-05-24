import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<String> names = TempDB.getMovieNames();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkerBackground,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
          titleTextStyle: theme.textTheme.titleLarge,
          toolbarTextStyle: theme.textTheme.bodyMedium,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ));
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
        return ListTile(
          title: Text(
            result,
            style: const TextStyle(color: AppColors.veryDark),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
        return ListTile(
          title: Text(
            result,
            style: const TextStyle(color: AppColors.white),
          ),
          tileColor: AppColors.darkBackground,
        );
      },
    );
  }
}
