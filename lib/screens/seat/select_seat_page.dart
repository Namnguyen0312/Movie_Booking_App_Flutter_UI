import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/datasource/temp_db.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/built_seat_status_bar.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/movie_title.dart';

import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';

import '../../models/movie.dart';

class SelectSeatPage extends StatefulWidget {
  static const String routeName = '/select_seat_page';

  const SelectSeatPage({super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<Seat> selectedSeats = [];
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final movie = args['movie'] as Movie;
    final screening = args['screening'] as Screening;

    // Function to handle seat toggle
    void toggleSeat(Seat seat) {
      setState(() {
        if (selectedSeats.contains(seat)) {
          selectedSeats.remove(seat);
          totalPrice -= seat.price;
        } else {
          selectedSeats.add(seat);
          totalPrice += seat.price;
        }
      });
    }

    // Build seat widgets using Container and GestureDetector
    List<Widget> buildSeatWidgets(List<Seat> seats) {
      return seats.map((seat) {
        // Check seat status
        SeatStatus status = seat.status;
        Color backgroundColor;
        bool selected = selectedSeats.contains(seat);

        if (status == SeatStatus.available) {
          backgroundColor = selected ? AppColors.blueMain : AppColors.grey;
        } else {
          backgroundColor = AppColors.darkBackground;
          selected = false;
        }

        return GestureDetector(
          onTap: () {
            if (status == SeatStatus.available) {
              toggleSeat(seat);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(1.0),
            width: size.width / 11.5,
            height: size.width / 11.5,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            alignment: Alignment.center,
            child: Text(
              seat.numberSeat,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      }).toList();
    }

    // Generate seat grid
    Widget generateSeatGrid() {
      List<String> seatRowLetters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
      List<Seat> seats = TempDB.tableSeat
          .where((seat) => seat.auditorium.id == screening.auditorium.id)
          .toList();

      return Column(
        children: seatRowLetters.map((rowLetter) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: seats
                .where((seat) => seat.numberSeat.startsWith(rowLetter))
                .map((seat) => buildSeatWidgets([seat]))
                .expand((element) => element)
                .toList(),
          );
        }).toList(),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArrowBackWhite(topPadding: kMinPadding),
            MovieTitle(
              nameMovie: movie.title.toString(),
              screening: screening,
            ),
            const Padding(
              padding: EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BuiltSeatStatusBar(
                    color: AppColors.grey,
                    status: 'Có sẵn',
                  ),
                  BuiltSeatStatusBar(
                    color: AppColors.darkBackground,
                    status: 'Đã hết',
                  ),
                  BuiltSeatStatusBar(
                    color: AppColors.blueMain,
                    status: 'Ghế của bạn',
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height / 10,
              child: Image.asset(
                AssetHelper.imgSeat,
                fit: BoxFit.fill,
              ),
            ),
            const Divider(
              color: AppColors.blueMain,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: generateSeatGrid(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giá vé',
                        style: AppStyles.h5.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.grey,
                        ),
                      ),
                      Text(
                        'Rp $totalPrice',
                        style: AppStyles.h3,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CheckOut.routeName,
                        arguments: {
                          'movie': movie,
                          'selectedSeats': selectedSeats,
                        },
                      );
                    },
                    child: Container(
                      height: 46,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.blueMain,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Đặt vé',
                        style: AppStyles.h4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
