import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';
import 'package:movie_ticker_app_flutter/utils/constants.dart';
import 'package:provider/provider.dart';

class MyTicketPage extends StatefulWidget {
  const MyTicketPage({super.key});

  @override
  State<MyTicketPage> createState() => _MyTicketPageState();
}

class _MyTicketPageState extends State<MyTicketPage> {
  bool _isLoading = true;
  bool _isAmberExpanded = false;

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
    final ticketProvider = context.watch<TicketProvider>();
    String seats = '';
    if (ticketProvider.ticketsByUser != null) {
      seats = ticketProvider.ticketsByUser!
          .map((ticket) => ticket.seats.map(
                (seat) => '${seat.rowSeat}${seat.numberSeat}',
              ))
          .join(', ');
    }

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
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
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
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAmberExpanded = false;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _isAmberExpanded
                                ? size.width / 8
                                : size.width / 1.15,
                            height: _isAmberExpanded
                                ? size.height / 5.3
                                : size.height / 5,
                            child: Card(
                              color: Colors.green.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Opacity(
                                  opacity: _isAmberExpanded ? 0 : 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          ticket.movieTitle,
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Flexible(
                                        child: Text(
                                          'Người dùng: ${ticket.userName}',
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Ngày: ${ticket.screeningDate}',
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Giờ bắt đầu: ${ticket.screeningStartTime}',
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Phòng chiếu: ${ticket.auditoriumName}',
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Ghế: $seats',
                                          style: GoogleFonts.beVietnamPro(
                                            textStyle: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAmberExpanded = true;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: _isAmberExpanded
                                ? size.width / 1.15
                                : size.width / 8,
                            height: size.height / 5.2,
                            child: Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(kDefaultPadding),
                                child: Opacity(
                                    opacity: _isAmberExpanded ? 1 : 0,
                                    child: Image.network(
                                      ticket.qrcode,
                                      fit: BoxFit.scaleDown,
                                    )),
                              ),
                            ),
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
