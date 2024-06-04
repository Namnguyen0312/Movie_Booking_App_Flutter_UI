import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:provider/provider.dart';

class SelectScreeningWidget extends StatelessWidget {
  const SelectScreeningWidget({
    super.key,
    required this.provider,
  });

  final AppProvider provider;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: provider.hasScreenings
          ? const Center(child: Text('Không có suất chiếu'))
          : ListView.builder(
              itemCount: provider.filteredScreeningsByMovie.length,
              itemBuilder: (context, index) {
                final movieTitle =
                    provider.filteredScreeningsByMovie.keys.elementAt(index);
                final screenings =
                    provider.filteredScreeningsByMovie[movieTitle]!;

                return SizedBox(
                  height: 130,
                  child: ListTile(
                    title: Text(movieTitle, style: AppStyles.h2),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: screenings.map((screening) {
                          final format = DateFormat("yyyy-MM-dd HH:mm");
                          final screeningDateTime = format
                              .parse('${screening.date} ${screening.start}');
                          final isPast =
                              screeningDateTime.isBefore(DateTime.now());
                          final isSelected =
                              provider.selectedScreening == screening;
                          return GestureDetector(
                            onTap: isPast
                                ? null
                                : () {
                                    context
                                        .read<AppProvider>()
                                        .selectScreening(screening);
                                    context
                                        .read<AppProvider>()
                                        .checkAndSetSelectMovie();
                                  },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 12),
                              child: SizedBox(
                                width: 80,
                                height: 40,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.blueMain
                                        : (isPast
                                            ? AppColors.grey
                                            : AppColors.darkerBackground),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.blueMain
                                          : AppColors.grey,
                                    ),
                                  ),
                                  child: Text(
                                    screening.start,
                                    style: const TextStyle(
                                        fontSize: 16, color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
