import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';

class SelectDateWidget extends StatefulWidget {
  const SelectDateWidget({super.key});

  @override
  State<SelectDateWidget> createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectCurrentDate();
    });
  }

  void _selectCurrentDate() {
    final appProvider = context.read<AppProvider>();

    final today = DateTime.now();
    final currentDate = DateTime(today.year, today.month, today.day);

    final index = appProvider.days.indexWhere(
      (date) =>
          date.year == currentDate.year &&
          date.month == currentDate.month &&
          date.day == currentDate.day,
    );
    if (appProvider.selectedDate == null) {
      if (index != -1) {
        appProvider.updateIsSelected(index, appProvider.days);
        appProvider.selectDate(appProvider.days[index]);
        appProvider.getScreeningsByMovieAndCity(
          appProvider.selectedMovie!.id,
          appProvider.selectedCity!,
          appProvider.days[index],
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = context.watch<AppProvider>();

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
                await context.read<AppProvider>().getScreeningsByMovieAndCity(
                      provider.selectedMovie!.id,
                      provider.selectedCity!,
                      provider.days[index],
                    );
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
                      style: GoogleFonts.beVietnamPro(
                        textStyle: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: kMinPadding),
                      child: Text(
                        provider.days[index].day.toString(),
                        style: GoogleFonts.beVietnamPro(
                          textStyle: Theme.of(context).textTheme.labelSmall,
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
