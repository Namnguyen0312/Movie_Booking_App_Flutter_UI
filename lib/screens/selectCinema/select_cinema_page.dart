import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateful/title.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/custom_header.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/list_choose_day_widget.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/next_button.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/select_country.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/time_available_widget.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';

import '../../models/movie.dart';

class SelectCinemaPage extends StatefulWidget {
  const SelectCinemaPage({super.key});

  static const String routeName = '/select_cinema_page';

  @override
  State<SelectCinemaPage> createState() => _SelectCinemaPageState();
}

class _SelectCinemaPageState extends State<SelectCinemaPage> {
  final List<String> items = [
    'Cần Thơ',
    'Trà Vinh',
    'Hồ Chí Minh',
    'Hà Nội',
    'Bến Tre',
    'Tiền Giang',
  ];

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(size: size, content: movie.name.toString()),
            SelectCountry(
              size: size,
              items: items,
            ),
            const TitleHome(title: 'Chọn Ngày'),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kMediumPadding),
              child: ListChooseDay(size: size),
            ),
            const TitleHome(title: 'Central Park CGV'),
            TimeAvailable(size: size),
            const TitleHome(title: 'FX Sudirman XXI'),
            TimeAvailable(size: size),
            const TitleHome(title: 'Kelapa Gading IMAX'),
            TimeAvailable(size: size),
            NextButton(
              size: size,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SelectSeatPage.routeName,
                  arguments: movie,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
