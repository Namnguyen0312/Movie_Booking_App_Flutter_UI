import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';

import '../../../models/movie.dart';
import '../../../themes/app_styles.dart';
import '../../../utils/constants.dart';

class ListChooseDay extends StatefulWidget {
  const ListChooseDay({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ListChooseDay> createState() => _ListChooseDayState();
}

class _ListChooseDayState extends State<ListChooseDay> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List<bool>.generate(days.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          days.length,
          (index) => _buildDayItem(days[index], index),
        ),
      ),
    );
  }

  Widget _buildDayItem(String day, int index) {
    return GestureDetector(
      onTap: () {
        _updateSelected(index);
      },
      child: Container(
        height: widget.size.height / 8,
        width: widget.size.width / 5.5,
        margin: const EdgeInsets.only(right: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          color: _isSelected[index]
              ? AppColors.blueMain
              : AppColors.darkBackground,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day,
              style: AppStyles.h4.copyWith(
                color: AppColors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kMinPadding),
              child: Text(
                (20 + index).toString(),
                style: AppStyles.h5.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSelected(int selectedIndex) {
    setState(() {
      _isSelected = List<bool>.generate(
        days.length,
        (index) => index == selectedIndex ? true : false,
      );
    });
  }
}
