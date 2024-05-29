import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class AllCinema extends StatefulWidget {
  static const String routeName = '/all_cinema';

  const AllCinema({super.key});

  @override
  State<AllCinema> createState() => _AllCinemaState();
}

class _AllCinemaState extends State<AllCinema> {
  String? _selectedCity;

  @override
  void initState() {
    super.initState();
    Provider.of<AppProvider>(context, listen: false).getCityToAddress();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt vé theo rạp'),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                      final bool isSelected = city == _selectedCity;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCity = city;
                            });
                            provider.fetchCinemasByCity(city);
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
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: provider.cinemas.length,
                itemBuilder: (context, index) {
                  final cinema = provider.cinemas[index];
                  final address = cinema.address;
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ExpansionTile(
                      title: Text(
                        cinema.name,
                        style: AppStyles.h2,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(kMediumPadding),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: AppColors.grey,
                            ),
                            Text(
                              '${address.ward}, ${address.street}, ${address.district}, ${address.city},',
                              style: AppStyles.h5Light,
                            ),
                          ],
                        ),
                      ),
                      // children: cinema.map((movie) {
                      //   return ListTile(
                      //     title: Text(
                      //       movie.title,
                      //       style: AppStyles.h3,
                      //     ),
                      //     subtitle: Text(
                      //       movie.description,
                      //       style: AppStyles.h5Light,
                      //     ),
                      //     onTap: () {
                      //       // Add your logic when tapping on a movie
                      //     },
                      //   );
                      // }).toList(),
                      // controlAffinity: ListTileControlAffinity.trailing,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
