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
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final userProvider = context.watch<UserProvider>();

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
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Chip(
                          label: Text(
                            city,
                            style: GoogleFonts.beVietnamPro(
                              textStyle:
                                  Theme.of(context).textTheme.labelMedium,
                            ),
                          ),
                          backgroundColor: isSelected
                              ? AppColors.blueMain
                              : AppColors.darkerBackground,
                          labelPadding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: isSelected
                                ? const BorderSide(color: AppColors.blueMain)
                                : BorderSide.none,
                          ),
                        ),
                        if (userProvider.isLoggedIn)
                          if (userProvider.user!.address.city.contains(city))
                            Positioned(
                              top: 2,
                              right: -8,
                              child: Transform.rotate(
                                angle: 0.5, // Rotate -45 degrees
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 1.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Text(
                                    'Gần',
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    )));
          }).toList(),
        ),
      ),
    );
  }
}
