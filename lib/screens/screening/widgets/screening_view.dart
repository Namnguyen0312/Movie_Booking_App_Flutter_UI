import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class ScreeningView extends StatelessWidget {
  final List<Screening> screenings;
  final String name;
  final Function(Screening) onSelect;

  const ScreeningView({
    required this.screenings,
    required this.name,
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);

    return Padding(
      padding:
          const EdgeInsets.only(left: kDefaultPadding, bottom: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: AppStyles.h2),
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: screenings.length,
              itemBuilder: (context, index) {
                final screening = screenings[index];
                final format = DateFormat("yyyy-MM-dd HH:mm");
                final screeningDateTime =
                    format.parse('${screening.date} ${screening.start}');
                final isPast = screeningDateTime.isBefore(DateTime.now());
                final isSelected = provider.selectedScreening == screening;

                return GestureDetector(
                  onTap: isPast
                      ? null
                      : () {
                          provider.selectScreening(screening);
                          onSelect(screening);
                        },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kMinPadding),
                    child: Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: kSmallBorderRadius,
                      ),
                      child: Container(
                        width: 40,
                        padding: const EdgeInsets.all(kDefaultPadding),
                        decoration: BoxDecoration(
                          borderRadius: kSmallBorderRadius,
                          color: isSelected
                              ? AppColors.blueMain
                              : (isPast
                                  ? AppColors.darkBackground
                                  : AppColors.grey),
                        ),
                        child: Center(
                          child: Text(
                            screening.start,
                            style: const TextStyle(
                              fontSize: 4.0,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
