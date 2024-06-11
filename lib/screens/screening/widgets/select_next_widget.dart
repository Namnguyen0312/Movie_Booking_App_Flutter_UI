import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_screen.dart';
import 'package:movie_ticker_app_flutter/screens/screening/select_screening_by_movie_page.dart';
import 'package:movie_ticker_app_flutter/screens/seat/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({
    super.key,
    required this.size,
    required this.userProvider,
  });

  final Size size;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          if (userProvider.isLoggedIn) {
            context.read<SeatProvider>().reset();
            context
                .read<AppProvider>()
                .selectWidget(const SelectScreeningByMoviePage());
            Navigator.of(context).push(
              AnimateLeftCurve.createRoute(const SelectSeatPage()),
            );
          } else {
            context
                .read<AppProvider>()
                .selectWidget(const SelectScreeningByMoviePage());
            context.read<UserProvider>().selectWidget(const SelectSeatPage());
            Navigator.of(context).push(
              AnimateLeftCurve.createRoute(const LoginScreen()),
            );
          }
        },
        child: Container(
          height: size.height / 16,
          width: size.width / 3,
          decoration: BoxDecoration(
            color: AppColors.blueMain,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              color: context.watch<AppProvider>().selectedScreening != null
                  ? AppColors.white
                  : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
