import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/select_screeing_by_cinema_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
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
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

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
                children: provider.citys.map((city) {
                  final bool isSelected = city == provider.selectedCity;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () async {
                        context.read<AppProvider>().selectCity(city);
                        await context
                            .read<AppProvider>()
                            .fetchCinemasByCity(city);
                      },
                      child: Chip(
                        label: Text(
                          city,
                          style: const TextStyle(fontSize: 16),
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
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          provider.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: provider.cinemas.length,
                  itemBuilder: (context, index) {
                    final cinema = provider.cinemas[index];
                    final address = cinema.address;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cinema.name,
                              style: AppStyles.h2,
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
                                    style: AppStyles.h5Light,
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
                          Navigator.of(context).pushNamed(
                            SelectScreeningByCinema.routeName,
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
