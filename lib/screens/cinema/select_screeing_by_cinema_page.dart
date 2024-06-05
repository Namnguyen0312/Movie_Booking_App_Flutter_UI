import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_date_widget.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_next_widget.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_screening_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectScreeningByCinema extends StatefulWidget {
  const SelectScreeningByCinema({super.key});
  static const String routeName = '/all_screening';

  @override
  State<SelectScreeningByCinema> createState() =>
      _SelectScreeningByCinemaState();
}

class _SelectScreeningByCinemaState extends State<SelectScreeningByCinema> {
  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    Future.microtask(() {
      appProvider.resetForCinema();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(provider.selectedCinema!.name),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SelectDateWidget(
              provider: provider,
              size: size,
            ),
            const SizedBox(
              height: 20,
            ),
            if (provider.dateSelected) const SelectScreeningWidget(),
            if (provider.selectedScreening != null)
              SelectNextWidget(provider: provider, size: size),
          ],
        ),
      ),
    );
  }
}
