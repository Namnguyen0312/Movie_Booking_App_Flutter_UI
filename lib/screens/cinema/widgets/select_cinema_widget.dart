import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/select_screeing_by_cinema_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class SelectCinemaWidget extends StatefulWidget {
  const SelectCinemaWidget({
    super.key,
  });

  @override
  State<SelectCinemaWidget> createState() => _SelectCinemaWidgetState();
}

class _SelectCinemaWidgetState extends State<SelectCinemaWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preselectUserCity();
    });
  }

  void _preselectUserCity() {
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
          appProvider.fetchCinemasByCity(matchingCity);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          SingleChildScrollView(
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
                          await context
                              .read<AppProvider>()
                              .fetchCinemasByCity(city);
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
                                    ? const BorderSide(
                                        color: AppColors.blueMain)
                                    : BorderSide.none,
                              ),
                            ),
                          ],
                        )),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          appProvider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appProvider.cinemas.length,
                  itemBuilder: (context, index) {
                    final cinema = appProvider.cinemas[index];
                    final address = cinema.address;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cinema.name,
                              style: GoogleFonts.beVietnamPro(
                                textStyle:
                                    Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: AppColors.grey,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '${address.ward}, ${address.street}, ${address.district}, ${address.city}',
                                    style: GoogleFonts.beVietnamPro(
                                      textStyle: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    softWrap: true,
                                    maxLines: null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          context.read<AppProvider>().selectCinema(cinema);
                          context.read<AppProvider>().resetForCinema();

                          Navigator.of(context).push(
                            AnimateLeftCurve.createRoute(
                                const SelectScreeningByCinema()),
                          );
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
