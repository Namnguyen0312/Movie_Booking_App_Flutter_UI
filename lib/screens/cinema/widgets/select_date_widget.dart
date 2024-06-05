import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';

class SelectDateWidget extends StatelessWidget {
  final AppProvider provider;
  final Size size;

  const SelectDateWidget({
    super.key,
    required this.provider,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: List.generate(provider.days.length, (index) {
            return GestureDetector(
              onTap: () async {
                context
                    .read<AppProvider>()
                    .updateIsSelected(index, provider.days);
                context.read<AppProvider>().selectDate(provider.days[index]);
                context.read<AppProvider>().getScreeningsByCinema(
                    provider.selectedCinema!.id, provider.days[index]);
              },
              child: Container(
                height: size.height / 10,
                width: size.width / 6,
                margin: const EdgeInsets.only(right: kDefaultPadding),
                decoration: BoxDecoration(
                  borderRadius: kDefaultBorderRadius,
                  color: provider.isSelected[index]
                      ? AppColors.blueMain
                      : AppColors.darkerBackground,
                  border: provider.isSelected[index]
                      ? null
                      : Border.all(color: AppColors.grey),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDay(provider.days[index]),
                      style: AppStyles.h4.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kMinPadding),
                      child: Text(
                        provider.days[index].day.toString(),
                        style: AppStyles.h5.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  String _formatDay(DateTime date) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[date.weekday % 7];
  }
}
