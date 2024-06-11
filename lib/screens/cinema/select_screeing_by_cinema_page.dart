import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/select_cinema_page.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_date_widget.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_next_widget.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_screening_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:provider/provider.dart';

class SelectScreeningByCinema extends StatefulWidget {
  const SelectScreeningByCinema({super.key});

  @override
  State<SelectScreeningByCinema> createState() =>
      _SelectScreeningByCinemaState();
}

class _SelectScreeningByCinemaState extends State<SelectScreeningByCinema> {
  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final userProvider = context.watch<UserProvider>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          appProvider.selectedCinema!.name,
          style: GoogleFonts.beVietnamPro(
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                AnimateRightCurve.createRoute(const SelectCinemaByCity()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SelectDateWidget(),
            const SizedBox(
              height: 20,
            ),
            if (appProvider.dateSelected) const SelectScreeningWidget(),
            if (appProvider.selectedScreening != null)
              NextButtonWidget(userProvider: userProvider, size: size),
          ],
        ),
      ),
    );
  }
}
