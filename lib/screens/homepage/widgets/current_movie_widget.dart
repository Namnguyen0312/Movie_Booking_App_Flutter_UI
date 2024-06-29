import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class CurrentMovieWidget extends StatelessWidget {
  const CurrentMovieWidget({
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

  final Size size;
  final ValueNotifier<String?> _currentMovieImage;
  final TabController _tabController;
  final ValueNotifier<String> _currentMovieTitle;
  final ValueNotifier<String> _currentMovieGenres;
  final ValueNotifier<String> _currentMovieDuration;
  final ValueNotifier<double> _currentMovieStar;
  final List<MovieResponse> movies;

  void _updateCurrentMovie() {
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateCurrentMovie());
    return movies.isEmpty
        ? const Center(
            child: Text('Không có phim'),
          )
        : SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Stack(
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
                              height: size.height,
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
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: size.height / 16,
                          left: size.width / 6,
                          right: size.width / 6),
                      decoration: BoxDecoration(
                        color: AppColors.darkerBackground,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: size.width / 3.1,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 3,
                              color: Colors.white,
                            ),
                          ),
                          TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            controller: _tabController,
                            labelColor: Colors.pink,
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
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height / 24),
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
                      margin: EdgeInsets.only(top: size.height / 24),
                      child: CarouselSliderFirm(
                        size: size,
                        movies: movies,
                        onMovieChanged: (movie) {
                          _currentMovieImage.value = movie.image;
                          _currentMovieTitle.value = movie.title;
                          _currentMovieGenres.value = movie.genres
                              .map((genre) => genre.name)
                              .join(', ');
                          _currentMovieDuration.value =
                              '${movie.duration} phút';
                          _currentMovieStar.value = movie.rating;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
