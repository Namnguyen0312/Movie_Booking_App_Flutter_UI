import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/cinema/widgets/select_cinema_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:provider/provider.dart';

class SelectCinemaByCity extends StatefulWidget {
  static const String routeName = '/all_cinema';

  const SelectCinemaByCity({super.key});

  @override
  State<SelectCinemaByCity> createState() => _SelectCinemaByCityState();
}

class _SelectCinemaByCityState extends State<SelectCinemaByCity> {
  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    Future.microtask(() {
      appProvider.reset();
      appProvider.getCityToAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Đặt vé theo rạp',
          style: GoogleFonts.beVietnamPro(
            textStyle: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: provider.isCityLoading
            ? const Center(child: CircularProgressIndicator())
            : const SelectCinemaWidget(),
      ),
    );
  }
}
