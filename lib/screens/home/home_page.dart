import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateful/title.dart';
import 'package:movie_ticker_app_flutter/data/temp_db.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/coming_soon.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/promo.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Menu(),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: const Icon(
                Icons.search,
                color: AppColors.grey,
              )),
        ],
        backgroundColor: AppColors.darkerBackground,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: AppColors.grey),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          // CategoryBar(size: size),
          const TitleHome(title: 'Đang Chiếu'),
          CarouselSliderFirm(size: size),
          const Padding(
            padding: EdgeInsets.only(
              top: kTop32Padding,
              bottom: kMediumPadding,
            ),
            child: TitleHome(title: 'Sắp Chiếu'),
          ),
          ComingSoon(
            movies: TempDB.movies,
          ),
          const TitleHome(title: 'Khuyến Mãi'),
          Promo(
            size: size,
            content: 'Student Holiday',
            title: 'Maximal only for two people',
            discount: '50%',
          ),
          Promo(
            size: size,
            content: 'ThankGiving Holiday',
            title: 'Maximal only for five people',
            discount: '20%',
          ),
          Promo(
            size: size,
            content: 'Winter Holiday',
            title: 'Maximal only for eight people',
            discount: '10%',
          ),
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> names = TempDB.getMovieNames();

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.darkerBackground,
          iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
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
