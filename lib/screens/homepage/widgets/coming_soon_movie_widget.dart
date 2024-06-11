import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class ComingSoonMovieWidget extends StatelessWidget {
  const ComingSoonMovieWidget({
    super.key,
    required ValueNotifier<String?> currentMovieImage,
    required this.size,
    required TabController tabController,
    required ValueNotifier<String> currentMovieTitle,
    required ValueNotifier<String> currentMovieGenres,
    required ValueNotifier<String> currentMovieDuration,
    required ValueNotifier<double> currentMovieStar,
    required this.movies,
  })  : _currentMovieImage = currentMovieImage,
        _tabController = tabController,
        _currentMovieTitle = currentMovieTitle,
        _currentMovieGenres = currentMovieGenres,
        _currentMovieDuration = currentMovieDuration,
        _currentMovieStar = currentMovieStar;

  final ValueNotifier<String?> _currentMovieImage;
  final Size size;
  final TabController _tabController;
  final ValueNotifier<String> _currentMovieTitle;
  final ValueNotifier<String> _currentMovieGenres;
  final ValueNotifier<String> _currentMovieDuration;
  final ValueNotifier<double> _currentMovieStar;
  final List<MovieResponse> movies;

  void _updateComingSoonMovie() {
    if (movies.isNotEmpty) {
      _currentMovieImage.value = movies[0].image;
      _currentMovieTitle.value = movies[0].title;
      _currentMovieGenres.value =
          movies[0].genres.map((genre) => genre.name).join(', ');
      _currentMovieDuration.value = '${movies[0].duration} phút';
      _currentMovieStar.value = movies[0].rating;
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _updateComingSoonMovie());

    return movies.isEmpty
        ? const Center(
            child: Text('Không có phim'),
          )
        : Stack(
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
              Positioned(
                top: size.height / 5, // Adjust based on your design
                left: size.width / 6,
                right: size.width / 6,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white70, width: 3),
                  ),
                  child: Stack(
                    children: [
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        indicatorColor: Colors.transparent,
                        controller: _tabController,
                        labelColor: Colors.greenAccent.shade200,
                        unselectedLabelColor: Colors.white,
                        tabs: [
                          Tab(
                            child: Text(
                              'Đang chiếu',
                              style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(fontSize: 15)),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Sắp chiếu',
                              style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        left: size.width / 3.1, // Adjust based on your design
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
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
                              textStyle: Theme.of(context).textTheme.titleLarge,
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
                              textStyle: Theme.of(context).textTheme.labelLarge,
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
}
