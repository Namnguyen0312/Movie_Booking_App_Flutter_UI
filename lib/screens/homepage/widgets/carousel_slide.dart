import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import '../../movieDetail/movie_detail_page.dart';

class CarouselSliderFirm extends StatefulWidget {
  const CarouselSliderFirm({
    super.key,
    required this.size,
    required this.movies,
    required this.onMovieChanged,
  });

  final Size size;
  final List<MovieResponse> movies;
  final Function(MovieResponse) onMovieChanged;

  @override
  State<CarouselSliderFirm> createState() => _CarouselSliderFirmState();
}

class _CarouselSliderFirmState extends State<CarouselSliderFirm> {
  void _showMovieDialog(BuildContext context, MovieResponse movie) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          elevation: 10,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.title,
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(
                height: kMinPadding,
              ),
              Text(
                'Thể loại: ${movie.genres.map((genre) => genre.name).join(', ')}',
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: kMinPadding,
              ),
              Text(
                '${movie.duration} phút',
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              const SizedBox(
                height: kMinPadding,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: widget.size.width / 4,
                ),
                child: ListStarWidget(
                  rating: movie.rating,
                ),
              ),
              const SizedBox(
                height: kDefaultPadding,
              ),
              CachedNetworkImage(
                imageUrl: movie.image,
                placeholder: (context, url) => const Center(
                  child: SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 50.0,
                  ),
                ),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
                fit: BoxFit.cover,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: CarouselSlider(
        options: CarouselOptions(
          height: widget.size.height / 2.6,
          initialPage: 0,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          viewportFraction: 0.6,
          onPageChanged: (index, reason) {
            widget.onMovieChanged(widget.movies[index]);
          },
        ),
        items: widget.movies.map((movie) {
          return Builder(
            builder: (BuildContext context) {
              return GestureDetector(
                onLongPress: () {
                  _showMovieDialog(context, movie);
                },
                onTap: () {
                  context.read<AppProvider>().selectMovie(movie);
                  context.read<AppProvider>().checkComingSoon(movie);
                  Navigator.of(context).push(
                    AnimateLeftCurve.createRoute(const MovieDetailPage()),
                  );
                },
                child: Container(
                  width: widget.size.width,
                  height: widget.size.height,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: const BoxDecoration(
                    color: AppColors.lightBlueNon,
                    borderRadius: kBigBorderRadius,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: movie.image,
                    placeholder: (context, url) => const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.grey,
                        size: 50.0,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
