import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../themes/app_colors.dart';
import '../../../utils/constants.dart';

// ignore: must_be_immutable
class ArrowBackBlack extends StatelessWidget {
  double topPadding;

  ArrowBackBlack({
    super.key,
    required this.topPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding, left: kItemPadding),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const FaIcon(
          FontAwesomeIcons.arrowLeft,
          color: AppColors.veryDark,
        ),
      ),
    );
  }
}
