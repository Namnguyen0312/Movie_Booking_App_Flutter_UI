import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateful/title.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/category_bar.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/coming_soon.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/promo.dart';
import 'package:movie_ticker_app_flutter/screens/home/widgets/search_bar.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarOpacity = 0.0;
  final ValueNotifier<Color> _iconColorNotifier =
      ValueNotifier<Color>(Colors.black);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      setState(() {
        _appBarOpacity = offset / 400;
        if (_appBarOpacity > 1) _appBarOpacity = 1;
        _iconColorNotifier.value =
            _appBarOpacity > 0.5 ? Colors.white : Colors.black;
      });
    });
    _loadMovies();
  }

  void _loadMovies() {
    setState(() {
      movies = addListMovie(movies);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _iconColorNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const Menu(),
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: AppColors.text,
                floating: false,
                pinned: true,
                leading: Builder(
                  builder: (BuildContext context) {
                    return ValueListenableBuilder<Color>(
                      valueListenable: _iconColorNotifier,
                      builder: (context, iconColor, child) {
                        return IconButton(
                          icon: Icon(Icons.menu, color: iconColor),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SearchBarFirm(size: size),
                    CategoryBar(size: size),
                    const TitleHome(title: 'Đang Chiếu'),
                    CarouselSliderFirm(size: size),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: kTop32Padding,
                        bottom: kMediumPadding,
                      ),
                      child: TitleHome(title: 'Sắp Chiếu'),
                    ),
                    ComingSoon(
                      movies: movies,
                    ),
                    const TitleHome(title: 'Khuyến Mãi'),
                    Promo(
                      size: size,
                      content: 'Student Holiday',
                      title: 'Maximal only for two people',
                      discount: '50%',
                    ),
                    Promo(
                      size: size,
                      content: 'ThankGiving Holiday',
                      title: 'Maximal only for five people',
                      discount: '20%',
                    ),
                    Promo(
                      size: size,
                      content: 'Winter Holiday',
                      title: 'Maximal only for eight people',
                      discount: '10%',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Opacity(
            opacity: _appBarOpacity,
            child: Container(
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              color: AppColors.darkerBackground,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: Builder(
                  builder: (BuildContext context) {
                    return ValueListenableBuilder<Color>(
                      valueListenable: _iconColorNotifier,
                      builder: (context, iconColor, child) {
                        return IconButton(
                          icon: Icon(Icons.menu, color: iconColor),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
