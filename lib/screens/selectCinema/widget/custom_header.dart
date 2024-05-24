import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';

import '../../../themes/app_styles.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    super.key,
    required this.size,
    required this.content,
    required String title,
  });

  final Size size;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size.height / 10,
          child: Center(
            child: Text(
              content,
              style: AppStyles.h2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        ArrowBackWhite(topPadding: 0),
      ],
    );
  }
}
