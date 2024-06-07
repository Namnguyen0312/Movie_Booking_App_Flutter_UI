import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<void> _fetchMoviesFuture;
  String? _currentMovieImage = '';
  String _currentMovieTitle = '';
  String _currentMovieGenres = '';
  String _currentMovieDuration = '';
  double _currentMovieStar = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchMoviesFuture = context.read<AppProvider>().fetchMovies();
  }

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
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
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
            final List<Movie> movies = context.read<AppProvider>().movies;
            _currentMovieImage = movies.isNotEmpty ? movies[0].image : null;
            _currentMovieImage = movies[0].image;
            _currentMovieTitle = movies[0].title;
            _currentMovieGenres =
                movies[0].genres.map((genre) => genre.name).join(', ');
            _currentMovieDuration = movies[0].duration.toString();
            _currentMovieStar = movies[0].rating;
            return Stack(
              children: [
                _currentMovieImage != null
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                CachedNetworkImageProvider(_currentMovieImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: size.height / 3.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          _currentMovieTitle,
                          style: GoogleFonts.beVietnamPro(
                            textStyle: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Center(
                        child: Text(
                          _currentMovieGenres, // Thể loại bộ phim
                          style: GoogleFonts.beVietnamPro(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          '$_currentMovieDuration phút', // Thể loại bộ phim
                          style: GoogleFonts.beVietnamPro(
                            textStyle: Theme.of(context).textTheme.labelMedium,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: size.width / 2.8, top: size.height / 120),
                          child: ListStarWidget(
                            rating: _currentMovieStar,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height / 2),
                  child: CarouselSliderFirm(
                    size: size,
                    movies: movies,
                    onMovieChanged: (movie) {
                      setState(() {
                        _currentMovieImage = movie.image;
                        _currentMovieTitle = movie.title;
                        _currentMovieGenres =
                            movie.genres.map((genre) => genre.name).join(', ');
                        _currentMovieDuration = movie.duration.toString();
                        _currentMovieStar = movie.rating;
                      });
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
