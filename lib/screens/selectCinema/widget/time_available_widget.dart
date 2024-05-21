import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/movie.dart';
import '../../../themes/app_styles.dart';
import '../../../utils/constants.dart';

class TimeAvailable extends StatefulWidget {
  const TimeAvailable({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<TimeAvailable> createState() => _TimeAvailableState();
}

class _TimeAvailableState extends State<TimeAvailable> {
  late List<DateTime> _times;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _times = List<DateTime>.generate(
      times.length,
      (index) => DateFormat("HH:mm").parse(times[index]),
    );
    _selectedIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime.now();
    return Container(
      height: widget.size.height / 15,
      margin: const EdgeInsets.only(top: kItemPadding, left: kTopPadding),
      child: ListView.builder(
        itemBuilder: (context, index) {
          bool isPassed = _times[index].isBefore(currentTime);
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Container(
              width: widget.size.width / 4,
              margin: const EdgeInsets.only(left: kDefaultPadding),
              decoration: BoxDecoration(
                color: _selectedIndex == index
                    ? Colors.blue
                    : (isPassed ? Colors.grey : Colors.white),
                borderRadius: kDefaultBorderRadius,
              ),
              alignment: Alignment.center,
              child: Text(
                times[index],
                style: AppStyles.h4.copyWith(
                  color: _selectedIndex == index
                      ? Colors.white
                      : (isPassed ? Colors.black54 : Colors.black),
                ),
              ),
            ),
          );
        },
        itemCount: times.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
