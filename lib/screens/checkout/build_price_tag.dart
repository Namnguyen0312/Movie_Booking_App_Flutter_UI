import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/constants.dart';

class BuildPriceTag extends StatelessWidget {
  const BuildPriceTag({
    super.key,
    required this.content,
    required this.price,
  });

  final String content;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: kItemPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            content,
            style: GoogleFonts.beVietnamPro(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 70),
              child: Text(
                price,
                style: GoogleFonts.beVietnamPro(
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
