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
  const MyTicketPage({Key? key}) : super(key: key);

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
                if (ticketProvider.tickets!.isEmpty) {
                  return const Center(
                    child: Text('Không có vé nào'),
                  );
                }
                return ListView.builder(
                  itemCount: ticketProvider.tickets!.length,
                  itemBuilder: (context, index) {
                    final ticket = ticketProvider.tickets![index];
                    return Container(
                      margin: const EdgeInsets.all(kDefaultPadding),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ticket.movieTitle,
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Người dùng: ${ticket.userName}',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                'Ngày: ${ticket.screeningDate}',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                'Giờ bắt đầu: ${ticket.screeningStartTime}',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                'Phòng chiếu: ${ticket.auditoriumName}',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Text(
                                'Ghế: ${ticket.rowSeat} ${ticket.numberSeat}',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
