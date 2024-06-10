import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/movieDetail/widgets/about_title_widget.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required this.size,
    required this.appProvider,
    required this.cast,
  });

  final Size size;
  final AppProvider appProvider;
  final String cast;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: kDefaultPadding, horizontal: kDefaultIconSize),
            width: size.width,
            child: Text(
              appProvider.selectedMovie!.description,
              style: GoogleFonts.beVietnamPro(
                textStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: const AboutTitle(title: 'Đạo diễn')),
          Container(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding, horizontal: kDefaultIconSize),
              width: size.width,
              child: Text(
                appProvider.selectedMovie!.director,
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
          Container(
              alignment: Alignment.centerLeft,
              child: const AboutTitle(title: 'Diễn Viên')),
          Container(
              padding: const EdgeInsets.only(
                  top: kDefaultPadding,
                  bottom: kTop32Padding,
                  left: kDefaultIconSize,
                  right: kDefaultIconSize),
              width: size.width,
              child: Text(
                cast,
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              )),
        ],
      ),
    );
  }
}
