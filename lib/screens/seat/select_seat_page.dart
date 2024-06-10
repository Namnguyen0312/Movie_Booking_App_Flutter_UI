import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/built_seat_status_bar.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/movie_title.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
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
  late Future<void> _fetchSeatFuture;

  @override
  void initState() {
    super.initState();
    final seatProvider = Provider.of<SeatProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    _fetchSeatFuture = Future.microtask(() {
      seatProvider
          .getAllSeatByAuditorium(appProvider.selectedScreening!.auditorium.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final seatPovider = context.watch<SeatProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MovieTitle(),
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
            Expanded(
              child: SizedBox(
                height: size.height / 1.6,
                child: Container(
                  margin: EdgeInsets.only(top: size.height / 6),
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height / 10,
                        child: Image.asset(
                          AssetHelper.imgSeat,
                          fit: BoxFit.fill,
                        ),
                      ),
                      const Divider(
                        color: AppColors.grey,
                        thickness: 2,
                        indent: kDefaultPadding,
                        endIndent: kDefaultPadding,
                      ),
                      Expanded(
                        child: FutureBuilder<void>(
                          future: _fetchSeatFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              return Consumer<SeatProvider>(
                                builder: (context, seatProvider, child) {
                                  if (seatProvider.seats.isEmpty) {
                                    return const Center(
                                        child: Text('Rạp đang bảo trì'));
                                  } else {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.all(kDefaultPadding),
                                      child: generateSeatGrid(seatProvider),
                                    );
                                  }
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, bottom: kMediumPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Giá vé',
                        style: GoogleFonts.beVietnamPro(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      Consumer<SeatProvider>(
                        builder: (context, seatProvider, child) {
                          return Text(
                            '${seatProvider.totalPrice}00đ',
                            style: AppStyles.h3,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                if (seatPovider.selectedSeatIds.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: kDefaultPadding),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          AnimateLeftCurve.createRoute(const CheckOut()),
                        );
                      },
                      child: Container(
                        height: size.height / 16,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          color: AppColors.blueMain,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Đặt vé',
                          style: GoogleFonts.beVietnamPro(
                            textStyle: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget generateSeatGrid(SeatProvider seatProvider) {
    List<SeatResponse> sortedSeats = seatProvider.getSortedSeats();

    // Generate row letters based on the sorted seats
    List<String> seatRowLetters =
        sortedSeats.map((seat) => seat.rowSeat).toSet().toList()..sort();

    return Column(
      children: seatRowLetters.map((rowLetter) {
        List<SeatResponse> rowSeats =
            sortedSeats.where((seat) => seat.rowSeat == rowLetter).toList();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowSeats
              .map((seat) => buildSeatWidget(seatProvider, seat))
              .toList(),
        );
      }).toList(),
    );
  }

  Widget buildSeatWidget(SeatProvider seatProvider, SeatResponse seat) {
    final size = MediaQuery.of(context).size;

    return Consumer<SeatProvider>(
      builder: (context, provider, child) {
        bool selected = provider.selectedSeatIds.contains(seat.id);
        Color backgroundColor = selected ? AppColors.blueMain : AppColors.grey;

        return GestureDetector(
          onTap: () {
            provider.toggleSeat(seat);
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
              '${seat.rowSeat}${seat.numberSeat}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
