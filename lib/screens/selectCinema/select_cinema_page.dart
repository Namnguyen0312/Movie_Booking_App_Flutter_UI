import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/provider/cinema_provider.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/next_button.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/select_country.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/show_time_card.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/custom_header.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/list_choose_day_widget.dart';

class SelectCinemaPage extends StatelessWidget {
  static const String routeName = '/select_cinama_page';
  const SelectCinemaPage({super.key});

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;
    final cinemaProvider = Provider.of<CinemaProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              size: size,
              title: 'Chọn Rạp và Suất Chiếu',
              content: movie.title,
            ),
            SelectCountry(
              size: size,
              movie: movie,
            ),
            const SizedBox(
              height: kMediumPadding,
            ),
            ListChooseDay(
              size: size,
              movie: movie,
            ),
            Expanded(
              child: cinemaProvider.filteredScreenings.isEmpty
                  ? const Center(child: Text('No screenings available'))
                  : ListView.builder(
                      itemCount: cinemaProvider.filteredScreenings.length,
                      itemBuilder: (context, index) {
                        final screening =
                            cinemaProvider.filteredScreenings[index];
                        return ShowtimeCard(screening: screening);
                      },
                    ),
            ),
            NextButton(
              size: size,
              onPressed: cinemaProvider.selectedCity != null &&
                      cinemaProvider.selectedDate != null
                  ? () {
                      Navigator.of(context).pushNamed(SelectSeatPage.routeName,
                          arguments: movie);
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
