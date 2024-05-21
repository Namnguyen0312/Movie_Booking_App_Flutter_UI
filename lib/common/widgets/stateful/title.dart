import 'package:flutter/material.dart';

import '../../../themes/app_styles.dart';
import '../../../utils/constants.dart';

class TitleHome extends StatefulWidget {
  const TitleHome({super.key, required this.title});
  final String title;
  @override
  State<TitleHome> createState() => _TitleHomeState();
}

class _TitleHomeState extends State<TitleHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: kDefaultIconSize),
      padding: const EdgeInsets.only(left: kMediumPadding),
      alignment: Alignment.centerLeft,
      child: Text(
        widget.title,
        style: AppStyles.h2.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
