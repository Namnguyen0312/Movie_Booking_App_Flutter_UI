import 'dart:async';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
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
  late ValueNotifier<String?> _currentMovieImage;
  late ValueNotifier<String> _currentMovieTitle;
  late ValueNotifier<String> _currentMovieGenres;
  late ValueNotifier<String> _currentMovieDuration;
  late ValueNotifier<double> _currentMovieStar;

  @override
  void initState() {
    super.initState();
    _fetchMoviesFuture = context.read<AppProvider>().fetchMovies();
    _currentMovieImage = ValueNotifier<String?>(null);
    _currentMovieTitle = ValueNotifier<String>('');
    _currentMovieGenres = ValueNotifier<String>('');
    _currentMovieDuration = ValueNotifier<String>('');
    _currentMovieStar = ValueNotifier<double>(0.0);
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
            final List<MovieResponse> movies =
                context.watch<AppProvider>().movies;
            if (movies.isNotEmpty) {
              _currentMovieImage.value = movies[0].image;
              _currentMovieTitle.value = movies[0].title;
              _currentMovieGenres.value =
                  movies[0].genres.map((genre) => genre.name).join(', ');
              _currentMovieDuration.value = '${movies[0].duration} phút';
              _currentMovieStar.value = movies[0].rating;
            }

            return Stack(
              children: [
                ValueListenableBuilder<String?>(
                  valueListenable: _currentMovieImage,
                  builder: (context, currentMovieImage, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: currentMovieImage != null
                          ? Container(
                              key: ValueKey<String>(currentMovieImage),
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      currentMovieImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Container(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    );
                  },
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: size.height / 3.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ValueListenableBuilder<String>(
                          valueListenable: _currentMovieTitle,
                          builder: (context, currentMovieTitle, child) {
                            return Text(
                              currentMovieTitle,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: kDefaultPadding,
                      ),
                      Center(
                        child: ValueListenableBuilder<String>(
                          valueListenable: _currentMovieGenres,
                          builder: (context, currentMovieGenres, child) {
                            return Text(
                              currentMovieGenres,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                            );
                          },
                        ),
                      ),
                      Center(
                        child: ValueListenableBuilder<String>(
                          valueListenable: _currentMovieDuration,
                          builder: (context, currentMovieDuration, child) {
                            return Text(
                              currentMovieDuration,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.labelMedium,
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: size.width / 2.8, top: size.height / 120),
                        child: ValueListenableBuilder<double>(
                          valueListenable: _currentMovieStar,
                          builder: (context, currentMovieStar, child) {
                            return ListStarWidget(
                              rating: currentMovieStar,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height / 2),
                  child: CarouselSliderFirm(
                    size: size,
                    movies: movies,
                    onMovieChanged: (movie) {
                      _currentMovieImage.value = movie.image;
                      _currentMovieTitle.value = movie.title;
                      _currentMovieGenres.value =
                          movie.genres.map((genre) => genre.name).join(', ');
                      _currentMovieDuration.value = '${movie.duration} phút';
                      _currentMovieStar.value = movie.rating;
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
