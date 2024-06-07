import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';

class AboutTitle extends StatelessWidget {
  const AboutTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding, horizontal: kDefaultIconSize),
      child: Text(
        title,
        style: GoogleFonts.beVietnamPro(
          textStyle: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
