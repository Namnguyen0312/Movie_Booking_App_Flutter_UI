import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/list_star_widget.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/about_title_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/select_screening_by_movie_page.dart';
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
    Size size = MediaQuery.of(context).size;
    final provider = context.watch<AppProvider>();

    String genres =
        provider.selectedMovie!.genres.map((genre) => genre.name).join(', ');
    String cast = provider.selectedMovie!.casts.join(', ');

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            // BackgroundWidget(size: size),
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
                        child: Image.network(
                          provider.selectedMovie!.image,
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
                                provider.selectedMovie!.title,
                                style: AppStyles.h2,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                bottom: kDefaultPadding,
                              ),
                              width: size.width,
                              child: ListStarWidget(
                                  movie: provider.selectedMovie!),
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                  bottom: kDefaultPadding,
                                  left: kDefaultPadding,
                                ),
                                width: size.width,
                                child: Text(genres, style: AppStyles.h4)),
                            Container(
                              margin: const EdgeInsets.only(
                                left: kDefaultPadding,
                                bottom: kDefaultPadding,
                              ),
                              width: size.width,
                              child: Text(
                                'Thời lượng: ${provider.selectedMovie!.duration} phút',
                                style: AppStyles.h4,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    SelectScreeningByMoviePage.routeName,
                                    arguments: provider.selectedMovie!);
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
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: kDefaultIconSize),
                          width: size.width,
                          child: Text(
                            provider.selectedMovie!.description,
                            style: AppStyles.h4.copyWith(color: AppColors.grey),
                          )),
                      const AboutTitle(title: 'Đạo diễn'),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: kDefaultIconSize),
                          width: size.width,
                          child: Text(
                            provider.selectedMovie!.director,
                            style: AppStyles.h4.copyWith(color: AppColors.grey),
                          )),
                      const AboutTitle(title: 'Diễn Viên'),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding,
                              horizontal: kDefaultIconSize),
                          width: size.width,
                          child: Text(
                            cast,
                            style: AppStyles.h4.copyWith(color: AppColors.grey),
                          )),
                      // const AboutTitle(title: 'Trailer and song'),
                      // TrailerBar(movie: provider.selectedMovie!, size: size),
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
