import 'package:flutter/material.dart';

import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/review_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/comment_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/detail_widget.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/image_widget.dart';

import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();
    final reviewProvider = context.read<ReviewProvider>();
    final userProvider = context.watch<UserProvider>();

    String cast = appProvider.selectedMovie!.casts.join(', ');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                AnimateRightCurve.createRoute(const HomeScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: ImageWidget(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.indigo[100],
                      controller: _tabController,
                      labelColor: Colors.indigo[100],
                      unselectedLabelColor: Colors.white70,
                      tabs: const [
                        Tab(
                          text: "Mô Tả",
                        ),
                        Tab(text: "Bình Luận"),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 2,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          DetailWidget(
                              size: size, appProvider: appProvider, cast: cast),
                          CommentWidget(
                            reviewProvider: reviewProvider,
                            appProvider: appProvider,
                            userProvider: userProvider,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
