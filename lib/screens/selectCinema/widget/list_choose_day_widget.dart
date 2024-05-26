import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class ListChooseDay extends StatefulWidget {
  final Movie movie;
  const ListChooseDay({super.key, required this.size, required this.movie});

  final Size size;

  @override
  State<ListChooseDay> createState() => _ListChooseDayState();
}

class _ListChooseDayState extends State<ListChooseDay> {
  late List<bool> _isSelected;
  late List<DateTime> days;

  @override
  void initState() {
    super.initState();
    days = _generateDays();
    _isSelected = List<bool>.generate(days.length, (index) => false);
  }

  List<DateTime> _generateDays() {
    List<DateTime> days = [];
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      days.add(today.add(Duration(days: i)));
    }
    return days;
  }

  @override
  Widget build(BuildContext context) {
    final cinemaProvider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          days.length,
          (index) =>
              _buildDayItem(days[index], index, cinemaProvider, widget.movie),
        ),
      ),
    );
  }

  Widget _buildDayItem(
      DateTime day, int index, AppProvider cinemaProvider, Movie movie) {
    return GestureDetector(
      onTap: () {
        _updateSelected(index);
        cinemaProvider.selectDate(day, movie);
      },
      child: Container(
        height: widget.size.height / 8,
        width: widget.size.width / 5.5,
        margin: const EdgeInsets.only(right: kDefaultPadding),
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          color: _isSelected[index] ? AppColors.blueMain : AppColors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatDay(day),
              style: AppStyles.h4.copyWith(
                color: AppColors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: kMinPadding),
              child: Text(
                day.day.toString(),
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

  String _formatDay(DateTime date) {
    List<String> weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[date.weekday % 7];
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
