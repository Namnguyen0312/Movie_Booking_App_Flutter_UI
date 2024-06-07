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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: kMediumPadding),
          child: Text(
            appProvider.selectedScreening!.movie.title,
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
            '${appProvider.selectedScreening!.auditorium.name} ${appProvider.selectedScreening!.start}',
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ],
    );
  }
}
