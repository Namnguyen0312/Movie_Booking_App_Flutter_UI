import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/about_text_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/about_title_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/background_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/caster_bar.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/genres_bar.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/trailer_bar.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_cinema_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  static const String routeName = '/movie_detail_page';

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cinemaProvider = Provider.of<AppProvider>(context);
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            BackgroundWidget(size: size),
            Container(
              height: size.height / 3,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Gradients.darkGreyMid,
                    AppColors.darkerBackground,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            ArrowBackWhite(topPadding: kTop32Padding),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: kMediumPadding,
                    top: size.height / 4,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width / 2.5,
                        child: Image.asset(
                          movie.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                bottom: kMinPadding,
                              ),
                              width: size.width,
                              child: Text(
                                movie.title,
                                style: AppStyles.h2,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                bottom: kDefaultPadding,
                              ),
                              width: size.width,
                              child: ListStarWidget(movie: movie),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              width: size.width,
                              child: GenresBar(movie: movie),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                bottom: kDefaultPadding,
                              ),
                              width: size.width,
                              child: Text(
                                'Thời lượng: ${movie.duration} phút',
                                style: AppStyles.h4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                cinemaProvider.reset();
                                Navigator.of(context).pushNamed(
                                    SelectCinemaPage.routeName,
                                    arguments: movie);
                              },
                              child: Container(
                                height: size.height / 15,
                                width: size.height / 4.6,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Gradients.lightBlue1,
                                      Gradients.lightBlue2,
                                    ],
                                  ),
                                  borderRadius: kDefaultBorderRadius,
                                ),
                                child: Center(
                                  child: Text(
                                    'Đặt vé',
                                    style: AppStyles.h3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Divider(),
                SizedBox(
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const AboutTitle(title: 'Mô Tả'),
                      AboutText(text: movie.description),
                      const AboutTitle(title: 'Đạo diễn'),
                      ListBar(
                        list: movie.director,
                      ),
                      const AboutTitle(title: 'Diễn Viên'),
                      ListBar(
                        list: movie.casters,
                      ),
                      const AboutTitle(title: 'Trailer and song'),
                      TrailerBar(movie: movie, size: size),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
