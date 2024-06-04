import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../movieDetail/movie_detail_page.dart';

class CarouselSliderFirm extends StatefulWidget {
  const CarouselSliderFirm({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<CarouselSliderFirm> createState() => _CarouselSliderFirmState();
}

class _CarouselSliderFirmState extends State<CarouselSliderFirm> {
  late Future<void> _fetchMoviesFuture;

  @override
  void initState() {
    super.initState();
    _fetchMoviesFuture = context.read<AppProvider>().fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: _fetchMoviesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (provider.movies.isEmpty) {
              return const Center(child: Text('No movies available'));
            } else {
              return Padding(
                padding: const EdgeInsets.only(top: kDefaultPadding),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: widget.size.height / 2.2,
                    autoPlay: true,
                    initialPage: 0,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    viewportFraction: 0.6,
                  ),
                  items: provider.movies.map((movie) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            context.read<AppProvider>().selectMovie(movie);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MovieDetailPage(),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: widget.size.width,
                                height: widget.size.height,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBlueNon,
                                  borderRadius: kBigBorderRadius,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(movie.image)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            }
          },
        );
      },
    );
  }
}
