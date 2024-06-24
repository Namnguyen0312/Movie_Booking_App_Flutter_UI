import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/provider/app_provider.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/checkout/check_out.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/built_seat_status_bar.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/built_seat_type.dart';
import 'package:movie_ticker_app_flutter/screens/seat/widgets/movie_title.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/themes/app_styles.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:movie_ticker_app_flutter/utils/helper.dart';
import 'package:provider/provider.dart';

class SelectSeatPage extends StatefulWidget {
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
    final ticketProvider = Provider.of<TicketProvider>(context, listen: false);

    _fetchSeatFuture = Future.microtask(() {
      ticketProvider.getAllTicket();
      seatProvider.reset();
      seatProvider
          .getAllSeatByAuditorium(appProvider.selectedScreening!.auditorium.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final seatPovider = context.watch<SeatProvider>();
    final appProvider = context.watch<AppProvider>();
    final ticketProvider = context.watch<TicketProvider>();
    final userProvider = context.watch<UserProvider>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Chọn ghế',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                AnimateRightCurve.createRoute(appProvider.widget!),
                (route) => false,
              );
              // context.read<AppProvider>().reset();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white60,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  AnimateRightCurve.createRoute(const HomeScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white60,
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MovieTitle(),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const BuiltSeatStatusBar(
                        color: AppColors.grey,
                        status: 'Có sẵn',
                      ),
                      BuiltSeatStatusBar(
                        color: Colors.grey[850],
                        status: 'Đã hết',
                      ),
                      const BuiltSeatStatusBar(
                        color: AppColors.blueMain,
                        status: 'Ghế của bạn',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const BuiltSeatType(
                        color: Colors.green,
                        status: 'Thường',
                      ),
                      const BuiltSeatType(
                        color: Colors.red,
                        status: 'Vip',
                      ),
                      BuiltSeatStatusBar(
                        color: Colors.pink[200],
                        status: 'SweetBox',
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: size.height / 1.6,
                child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height / 11,
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
                                      child: CircularProgressIndicator());
                                } else {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.all(kDefaultPadding),
                                    child: generateSeatGrid(
                                        seatProvider,
                                        appProvider,
                                        ticketProvider,
                                        userProvider),
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
                          final totalPrice = int.parse(
                                  seatProvider.totalPrice.toStringAsFixed(0)) *
                              1000;
                          return Text(
                            '$totalPriceđ',
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

  Widget generateSeatGrid(SeatProvider seatProvider, AppProvider appProvider,
      TicketProvider ticketProvider, UserProvider userProvider) {
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
              .map((seat) => buildSeatWidget(seatProvider, appProvider,
                  ticketProvider, userProvider, seat))
              .toList(),
        );
      }).toList(),
    );
  }

  Widget buildSeatWidget(
      SeatProvider seatProvider,
      AppProvider appProvider,
      TicketProvider ticketProvider,
      UserProvider userProvider,
      SeatResponse seat) {
    final size = MediaQuery.of(context).size;
    bool seatAvailable = true;
    if (ticketProvider.tickets != null &&
        ticketProvider.checkSeat(seat.id, appProvider.selectedScreening!.id)) {
      seatAvailable = false;
    }
    bool seatByUser = false;
    if (ticketProvider.checkSeatByUser(seat.id, userProvider.user!.name)) {
      seatByUser = true;
    }

    return Consumer<SeatProvider>(
      builder: (context, provider, child) {
        bool selected = provider.selectedSeatIds.contains(seat.id);
        Color backgroundColor = Colors.transparent;
        if (!seatAvailable) {
          if (seatByUser) {
            backgroundColor = AppColors.blueMain;
          } else {
            backgroundColor = Colors.grey[850]!;
          }
        } else {
          if (seat.seatType == 'sweetBox' && !selected) {
            backgroundColor = Colors.pink[200]!;
          } else if (selected) {
            backgroundColor = AppColors.blueMain;
          }
        }
        Color borderColor = Colors.transparent;
        if (!seatAvailable) {
          if (seatByUser) {
            borderColor = AppColors.blueMain;
          } else {
            borderColor = Colors.grey[850]!;
          }
        } else {
          if (selected) {
            borderColor = Colors.transparent;
          } else if (seat.seatType == 'normal') {
            borderColor = Colors.green;
          } else if (seat.seatType == 'vip') {
            borderColor = Colors.red;
          }
        }

        return GestureDetector(
          onTap: () {
            if (seatAvailable) {
              provider.toggleSeat(seat);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(1.0),
            width: size.width / 11.5,
            height: size.width / 11.5,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
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
