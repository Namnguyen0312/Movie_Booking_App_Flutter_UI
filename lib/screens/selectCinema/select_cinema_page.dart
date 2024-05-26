import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/select_country.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/screening_view.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/select_seat_page.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/custom_header.dart';
import 'package:movie_ticker_app_flutter/screens/selectCinema/widget/list_choose_day_widget.dart';

class SelectCinemaPage extends StatefulWidget {
  static const String routeName = '/select_cinama_page';

  const SelectCinemaPage({super.key});

  @override
  State<SelectCinemaPage> createState() => _SelectCinemaPageState();
}

class _SelectCinemaPageState extends State<SelectCinemaPage> {
  Screening? selectedScreening;

  @override
  Widget build(BuildContext context) {
    Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<AppProvider>(context);
    final screeningsByCinema = provider.screeningsByCinema;

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
            const SizedBox(
              height: kMediumPadding,
            ),
            Expanded(
              child: provider.filteredScreenings.isEmpty
                  ? const Center(child: Text('Không có suất chiếu'))
                  : ListView.builder(
                      itemCount: screeningsByCinema.length,
                      itemBuilder: (context, index) {
                        final cinemaName =
                            screeningsByCinema.keys.elementAt(index);
                        final screenings = screeningsByCinema[cinemaName]!;
                        return ScreeningView(
                          screenings: screenings,
                          name: cinemaName,
                          onSelect: (screening) {
                            provider.selectScreening(screening);
                            setState(() {
                              selectedScreening = screening;
                            });
                          },
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: kMediumPadding, top: kTop32Padding),
              child: GestureDetector(
                onTap: selectedScreening != null
                    ? () {
                        Navigator.of(context).pushNamed(
                          SelectSeatPage.routeName,
                          arguments: {
                            'movie': movie,
                            'screening': selectedScreening,
                          },
                        );
                      }
                    : null,
                child: Container(
                  height: size.height / 15,
                  width: size.height / 7,
                  decoration: BoxDecoration(
                    gradient: selectedScreening != null
                        ? const LinearGradient(
                            colors: [
                              Gradients.lightBlue1,
                              Gradients.lightBlue2,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    color: selectedScreening == null ? Colors.black : null,
                    borderRadius: kDefaultBorderRadius,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: selectedScreening != null
                          ? AppColors.white
                          : AppColors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
