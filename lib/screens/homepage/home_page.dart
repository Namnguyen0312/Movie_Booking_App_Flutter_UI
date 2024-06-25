import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/response/movie_response.dart';
import 'package:movie_ticker_app_flutter/models/response/new_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/new_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/coming_soon_movie_widget.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/current_movie_widget.dart';
import 'package:movie_ticker_app_flutter/screens/news/news_detail_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
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
  late Future<void> _fetchNewsFuture;
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
    _fetchNewsFuture = context.read<NewProvider>().getAllNews();
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

  Widget buildAppBar(Size size) {
    return FutureBuilder(
      future: _fetchNewsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AppBar(
            title: const Center(child: CircularProgressIndicator()),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        } else if (snapshot.hasError) {
          return AppBar(
            title: Center(child: Text('Error: ${snapshot.error}')),
            backgroundColor: Colors.transparent,
            elevation: 0,
          );
        } else {
          final List<NewResponse> news = context.watch<NewProvider>().news!;

          if (news.isEmpty) {
            return const Center(
              child: Text('Không có vé nào'),
            );
          }
          return AppBar(
            flexibleSpace: CarouselSlider(
              options: CarouselOptions(
                height: size.height / 4.5,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
              ),
              items: news.map((newfeed) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        context.read<NewProvider>().selectNew(newfeed);
                        Navigator.of(context).push(
                          AnimateLeftCurve.createRoute(const NewsDetailPage()),
                        );
                      },
                      child: Container(
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: AppColors.lightBlueNon,
                          borderRadius: kBigBorderRadius,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: newfeed.imageUrl!,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
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
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Menu(),
      appBar: PreferredSize(
        preferredSize: size / 8,
        child: buildAppBar(size),
      ),
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
                  movies: currentMovies,
                ),
                ComingSoonMovieWidget(
                  currentMovieImage: _currentMovieImage,
                  size: size,
                  tabController: _tabController,
                  currentMovieTitle: _currentMovieTitle,
                  currentMovieGenres: _currentMovieGenres,
                  currentMovieDuration: _currentMovieDuration,
                  currentMovieStar: _currentMovieStar,
                  movies: commingSoonMovies,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
