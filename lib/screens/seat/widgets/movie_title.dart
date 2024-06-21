import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class MovieTitle extends StatelessWidget {
  const MovieTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    List<String> parts = [];
    String auditoriumName = '';
    if (appProvider.selectedScreening != null) {
      auditoriumName = appProvider.selectedScreening!.auditorium.name;
      parts = appProvider.selectedScreening!.start.split(':');
    }
    String start = '';
    if (parts.isNotEmpty) {
      start = '${parts[0]}:${parts[1]}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: kMediumPadding),
          child: Text(
            appProvider.selectedMovie!.title,
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(
          height: kMinPadding,
        ),
        Container(
          margin: const EdgeInsets.only(left: kMediumPadding),
          child: Text(
            '$auditoriumName $start',
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
