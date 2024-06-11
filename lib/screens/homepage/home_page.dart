import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/coming_soon_movie_widget.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/current_movie_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Future<void> _fetchMoviesFuture;
  late ValueNotifier<String?> _currentMovieImage;
  late ValueNotifier<String> _currentMovieTitle;
  late ValueNotifier<String> _currentMovieGenres;
  late ValueNotifier<String> _currentMovieDuration;
  late ValueNotifier<double> _currentMovieStar;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _fetchMoviesFuture = context.read<AppProvider>().fetchMovies();
    _currentMovieImage = ValueNotifier<String?>(null);
    _currentMovieTitle = ValueNotifier<String>('');
    _currentMovieGenres = ValueNotifier<String>('');
    _currentMovieDuration = ValueNotifier<String>('');
    _currentMovieStar = ValueNotifier<double>(0.0);
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _currentMovieImage.dispose();
    _currentMovieTitle.dispose();
    _currentMovieGenres.dispose();
    _currentMovieDuration.dispose();
    _currentMovieStar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final provider = context.watch<UserProvider>();
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
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: provider.isLoggedIn
            ? Text(
                'Chào, ${provider.user!.name}',
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : null,
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
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _fetchMoviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            context.read<AppProvider>().classifyMovie();
            final List<MovieResponse> currentMovies =
                context.watch<AppProvider>().currentMovies;
            final List<MovieResponse> commingSoonMovies =
                context.watch<AppProvider>().commingSoonMovies;
            return TabBarView(
              controller: _tabController,
              children: [
                CurrentMovieWidget(
                    currentMovieImage: _currentMovieImage,
                    size: size,
                    tabController: _tabController,
                    currentMovieTitle: _currentMovieTitle,
                    currentMovieGenres: _currentMovieGenres,
                    currentMovieDuration: _currentMovieDuration,
                    currentMovieStar: _currentMovieStar,
                    movies: currentMovies),
                ComingSoonMovieWidget(
                    currentMovieImage: _currentMovieImage,
                    size: size,
                    tabController: _tabController,
                    currentMovieTitle: _currentMovieTitle,
                    currentMovieGenres: _currentMovieGenres,
                    currentMovieDuration: _currentMovieDuration,
                    currentMovieStar: _currentMovieStar,
                    movies: commingSoonMovies)
              ],
            );
          }
        },
      ),
    );
  }
}
