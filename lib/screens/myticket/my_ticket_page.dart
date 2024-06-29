import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/models/response/seat_response.dart';
import 'package:movie_ticker_app_flutter/provider/seat_provider.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/myticket/ticket_detail.page.dart';
import 'package:movie_ticker_app_flutter/screens/myticket/widgets/ticket_detail_widget.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:provider/provider.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Fetch tickets here, after the context has fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = context.read<UserProvider>();
      Provider.of<TicketProvider>(context, listen: false)
          .getAllTicketByUserId(userProvider.user!.id)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Vé của tôi',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
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
            ),
          ),
        ],
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(
              child: SpinKitFadingCircle(
                color: Colors.grey,
                size: 50.0,
              ),
            )
          : Consumer<TicketProvider>(
              builder: (context, ticketProvider, child) {
                if (ticketProvider.ticketsByUser!.isEmpty) {
                  return const Center(
                    child: Text('Không có vé nào'),
                  );
                }
                return ListView.builder(
                  itemCount: ticketProvider.ticketsByUser!.length,
                  itemBuilder: (context, index) {
                    final ticket = ticketProvider.ticketsByUser![index];
                    final seatProvider = context.read<SeatProvider>();
                    List<SeatResponse> sortedSeats =
                        seatProvider.getSortedSeats(ticket.seats);
                    DateTime dateTime = DateTime.parse(ticket.orderTime);
                    String formattedString =
                        DateFormat('yyyy-MM-dd, HH:mm').format(dateTime);

                    String seats = sortedSeats
                        .map((seat) => '${seat.rowSeat}${seat.numberSeat}')
                        .join(', ');
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (!ticketProvider.checkScreeningEndTime(ticket)) {
                              Navigator.of(context).push(
                                AnimateLeftCurve.createRoute(TicketDetailPage(
                                  size: size,
                                  ticket: ticket,
                                  seats: seats,
                                )),
                              );
                            }
                          },
                          child: TicketDetailWidget(
                            size: size,
                            ticket: ticket,
                            seats: seats,
                            formattedString: formattedString,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
    );
  }
}
