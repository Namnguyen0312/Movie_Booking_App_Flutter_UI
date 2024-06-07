import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectScreeningWidget extends StatefulWidget {
  const SelectScreeningWidget({
    super.key,
  });

  @override
  State<SelectScreeningWidget> createState() => _SelectScreeningWidgetState();
}

class _SelectScreeningWidgetState extends State<SelectScreeningWidget> {
  Future<void>? _fetchScreeningsFuture;
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    if (provider.selectedCity != null &&
        provider.selectedDate != null &&
        _fetchScreeningsFuture == null) {
      _fetchScreeningsFuture = provider.getScreeningsByCinema(
        provider.selectedCinema!.id,
        provider.selectedDate!,
      );
    }

    return Expanded(
      child: _fetchScreeningsFuture == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _fetchScreeningsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return _buildScreeningList();
                }
              },
            ),
    );
  }

  Widget _buildScreeningList() {
    final provider = context.watch<AppProvider>();
    final screeningsByMovie = provider.screeningsByMovie;
    return screeningsByMovie.isEmpty
        ? Center(
            child: Text(
            'Không có suất chiếu',
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ))
        : ListView.builder(
            itemCount: screeningsByMovie.length,
            itemBuilder: (context, index) {
              final movieTitle = screeningsByMovie.keys.elementAt(index);
              final screenings = screeningsByMovie[movieTitle]!;
              return SizedBox(
                height: 130,
                child: ListTile(
                  title: Text(
                    movieTitle,
                    style: GoogleFonts.beVietnamPro(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
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
                                      .checkAndSetSelectCinema();
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
                                  style: GoogleFonts.beVietnamPro(
                                    textStyle:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
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
          );
  }
}
