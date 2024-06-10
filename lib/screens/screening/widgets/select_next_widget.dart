import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/screens/seat/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class SelectNextWidget extends StatelessWidget {
  const SelectNextWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return NextButtonWidget(size: size, provider: provider);
  }
}

class NextButtonWidget extends StatelessWidget {
  const NextButtonWidget({
    super.key,
    required this.size,
    required this.provider,
  });

  final Size size;
  final AppProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: GestureDetector(
        onTap: () {
          context.read<SeatProvider>().reset();
          Navigator.of(context).push(
            AnimateLeftCurve.createRoute(const SelectSeatPage()),
          );
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
              color: provider.selectedScreening != null
                  ? AppColors.white
                  : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
