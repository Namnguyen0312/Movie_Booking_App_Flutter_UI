import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/seat/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
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
    return Padding(
      padding:
          const EdgeInsets.only(bottom: kMediumPadding, top: kMediumPadding),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            SelectSeatPage.routeName,
          );
        },
        child: Container(
          height: size.height / 15,
          width: size.height / 9,
          decoration: const BoxDecoration(
            color: AppColors.blueMain,
            borderRadius: kDefaultBorderRadius,
            border: null,
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
