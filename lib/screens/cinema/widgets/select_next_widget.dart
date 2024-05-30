import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/seat/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class SelectNextWidget extends StatelessWidget {
  const SelectNextWidget({
    super.key,
    required this.provider,
    required this.size,
  });

  final AppProvider provider;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: kMediumPadding, top: kMediumPadding),
      child: GestureDetector(
        onTap: provider.selectedScreening != null
            ? () {
                Navigator.of(context).pushNamed(
                  SelectSeatPage.routeName,
                  arguments: {
                    'movie': provider.selectedMovie,
                    'screening': provider.selectedScreening,
                  },
                );
              }
            : null,
        child: Container(
          height: size.height / 15,
          width: size.height / 9,
          decoration: BoxDecoration(
            color: provider.selectedScreening == null
                ? AppColors.darkerBackground
                : AppColors.blueMain,
            borderRadius: kDefaultBorderRadius,
            border: provider.selectedScreening == null
                ? Border.all(color: AppColors.grey)
                : null,
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
