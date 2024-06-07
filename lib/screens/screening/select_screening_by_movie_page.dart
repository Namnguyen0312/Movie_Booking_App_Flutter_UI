import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_next_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_screening_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_date_widget.dart';
import 'package:movie_ticker_app_flutter/screens/screening/widgets/select_city_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectScreeningByMoviePage extends StatefulWidget {
  static const String routeName = '/select_cinema_page';

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
      appProvider.reset();
      appProvider.getCityToAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(provider.selectedMovie!.title),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (provider.isCityLoading)
              const Center(child: CircularProgressIndicator())
            else
              const SelectCityWidget(),
            const SizedBox(
              height: 20,
            ),
            if (provider.citySelected) const SelectDateWidget(),
            const SizedBox(
              height: 20,
            ),
            if (provider.citySelected && provider.dateSelected)
              const SelectScreeningWidget(),
            if (provider.selectedScreening != null)
              SelectNextWidget(size: size),
          ],
        ),
      ),
    );
  }
}
