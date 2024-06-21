import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectCityWidget extends StatefulWidget {
  const SelectCityWidget({super.key});

  @override
  State<SelectCityWidget> createState() => _SelectCityWidgetState();
}

class _SelectCityWidgetState extends State<SelectCityWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectUserCity();
    });
  }

  void _selectUserCity() {
    final appProvider = context.read<AppProvider>();
    final userProvider = context.read<UserProvider>();
    if (appProvider.selectedCity!.isEmpty) {
      if (userProvider.isLoggedIn) {
        final userCity = userProvider.user!.address.city;
        final matchingCity = appProvider.citys.firstWhere(
          (city) => userCity.contains(city),
          orElse: () => '',
        );
        if (matchingCity.isNotEmpty) {
          appProvider.selectCity(matchingCity);
          if (appProvider.dateSelected) {
            appProvider.getScreeningsByMovieAndCity(
              appProvider.selectedMovie!.id,
              matchingCity,
              appProvider.selectedDate!,
            );
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    if (appProvider.isCityLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: appProvider.citys.map((city) {
            final bool isSelected = city == appProvider.selectedCity;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () async {
                  context.read<AppProvider>().selectCity(city);
                  if (appProvider.dateSelected) {
                    await context
                        .read<AppProvider>()
                        .getScreeningsByMovieAndCity(
                          context.read<AppProvider>().selectedMovie!.id,
                          city,
                          context.read<AppProvider>().selectedDate!,
                        );
                  }
                },
                child: Chip(
                  label: Text(
                    city,
                    style: GoogleFonts.beVietnamPro(
                      textStyle: Theme.of(context).textTheme.labelMedium,
                    ),
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
