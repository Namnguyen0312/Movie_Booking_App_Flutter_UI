import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateful/title.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/carousel_slide.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/coming_soon.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/custom_serach_delegate.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/menu.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/widgets/promo.dart';
import 'package:provider/provider.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    Future.microtask(() {
      appProvider.reset();
    });
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
              )),
        ],
        backgroundColor: AppColors.darkerBackground,
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
      ),
      body: ListView(
        controller: _scrollController,
        children: [
          // CategoryBar(size: size),
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
            movies: TempDB.movies,
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
    );
  }
}
