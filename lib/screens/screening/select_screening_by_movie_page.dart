import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/movie_detail_page.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_next_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_screening_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_date_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_city_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:provider/provider.dart';

class SelectScreeningByMoviePage extends StatefulWidget {
  const SelectScreeningByMoviePage({super.key});

  @override
  State<SelectScreeningByMoviePage> createState() =>
      _SelectScreeningByMoviePageState();
}

class _SelectScreeningByMoviePageState
    extends State<SelectScreeningByMoviePage> {
  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    Future.microtask(() {
      appProvider.getCityToAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appProvider = context.watch<AppProvider>();
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appProvider.selectedMovie!.title,
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                AnimateRightCurve.createRoute(const MovieDetailPage()),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white60,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  AnimateRightCurve.createRoute(const HomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white60,
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            appProvider.isCityLoading
                ? const Center(child: CircularProgressIndicator())
                : const SelectCityWidget(),
            const SizedBox(
              height: 20,
            ),
            if (appProvider.citySelected) const SelectDateWidget(),
            const SizedBox(
              height: 20,
            ),
            if (appProvider.citySelected && appProvider.dateSelected)
              const SelectScreeningWidget(),
            if (appProvider.selectedScreening != null)
              NextButtonWidget(size: size, userProvider: userProvider),
          ],
        ),
      ),
    );
  }
}
