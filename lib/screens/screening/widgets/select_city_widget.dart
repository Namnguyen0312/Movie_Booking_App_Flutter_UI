import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectCityWidget extends StatelessWidget {
  const SelectCityWidget({
    super.key,
    required this.provider,
  });

  final AppProvider provider;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: provider.citys.map((city) {
            final bool isSelected = city == provider.selectedCity;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  context.read<AppProvider>().selectCity(city);
                  // context.read<AppProvider>().clearSelection();
                  if (!context.mounted) return;
                  if (provider.selectedDate != null) {
                    await context
                        .read<AppProvider>()
                        .getScreeningsByMovieAndCity(provider.selectedMovie!.id,
                            provider.selectedCity!, provider.selectedDate!);
                  }
                },
                child: Chip(
                  label: Text(
                    city,
                    style: const TextStyle(fontSize: 16),
                  ),
                  backgroundColor: isSelected
                      ? AppColors.blueMain
                      : AppColors.darkerBackground,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: isSelected
                        ? const BorderSide(color: AppColors.blueMain)
                        : BorderSide.none,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
