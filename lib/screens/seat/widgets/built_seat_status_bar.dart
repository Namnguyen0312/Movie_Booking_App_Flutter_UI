import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constants.dart';

class BuiltSeatStatusBar extends StatelessWidget {
  const BuiltSeatStatusBar({
    super.key,
    required this.color,
    required this.status,
  });

  final Color? color;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: kMediumPadding,
          width: kMediumPadding,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: kTopPadding),
          child: Text(
            status,
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
        ),
      ],
    );
  }
}
