import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/arrow_white_back.dart';
import 'package:movie_ticker_app_flutter/models/movie.dart';
import 'package:movie_ticker_app_flutter/models/screening.dart';
import 'package:movie_ticker_app_flutter/models/seat.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/built_seat_status_bar.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/movie_title.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';
import 'package:provider/provider.dart';

class SelectSeatPage extends StatefulWidget {
  static const String routeName = '/select_seat_page';

  const SelectSeatPage({super.key});

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  @override
  void initState() {
    super.initState();
    final seatProvider = Provider.of<SeatProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    Future.microtask(() {
      seatProvider.reset();
      seatProvider
          .getAllSeatByAuditorium(appProvider.selectedScreening!.auditorium.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final movie = args['movie'] as Movie;
    final screening = args['screening'] as Screening;
    final seatProvider = context.watch<SeatProvider>();

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
              child: Consumer<SeatProvider>(
                builder: (context, seatProvider, child) {
                  if (seatProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (seatProvider.seats.isEmpty) {
                    return const Center(
                      child: Text('Không có ghế'),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: generateSeatGrid(seatProvider),
                    );
                  }
                },
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
                      Consumer<SeatProvider>(
                        builder: (context, seatProvider, child) {
                          return Text(
                            'Rp ${seatProvider.totalPrice}',
                            style: AppStyles.h3,
                          );
                        },
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        CheckOut.routeName,
                        arguments: {
                          'movie': movie,
                          'selectedSeats': seatProvider.selectedSeats,
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

  Widget generateSeatGrid(SeatProvider seatProvider) {
    List<String> seatRowLetters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

    return Column(
      children: seatRowLetters.map((rowLetter) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: seatProvider.seats
              .where((seat) => seat.numberSeat.startsWith(rowLetter))
              .map((seat) => buildSeatWidgets(seatProvider, [seat]))
              .expand((element) => element)
              .toList(),
        );
      }).toList(),
    );
  }

  List<Widget> buildSeatWidgets(SeatProvider seatProvider, List<Seat> seats) {
    final size = MediaQuery.of(context).size;

    return seats.map((seat) {
      SeatStatus status = seat.status;
      Color backgroundColor;
      bool selected = seatProvider.selectedSeats.contains(seat);

      if (status == SeatStatus.available) {
        backgroundColor = selected ? AppColors.blueMain : AppColors.grey;
      } else {
        backgroundColor = AppColors.darkBackground;
        selected = false;
      }

      return GestureDetector(
        onTap: () {
          if (status == SeatStatus.available) {
            seatProvider.toggleSeat(seat);
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
}
