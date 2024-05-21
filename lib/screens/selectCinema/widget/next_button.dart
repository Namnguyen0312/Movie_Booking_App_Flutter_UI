import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.size,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kTop32Padding),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            height: size.height / 14,
            width: size.width / 4,
            decoration: BoxDecoration(
              color: AppColors.darkBackground,
              border: Border.all(width: 4, color: AppColors.grey),
              borderRadius: kDefaultBorderRadius,
            ),
            child: const Icon(
              Icons.arrow_right_alt,
              color: AppColors.grey,
            )),
      ),
    );
  }
}
