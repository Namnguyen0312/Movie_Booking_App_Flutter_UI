import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/provider/ticket_provider.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/myticket/widgets/ticket_detail_widget.dart';
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
                    ticket.seats.sort(
                      (a, b) => a.id.compareTo(b.id),
                    );
                    String seats = '';
                    seats = ticket.seats
                        .map(
                          (seat) => '${seat.rowSeat}${seat.numberSeat}',
                        )
                        .join(', ');
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isAmberExpanded = false;
                            });
                          },
                          child: TicketDetailWidget(
                            isAmberExpanded: _isAmberExpanded,
                            size: size,
                            ticket: ticket,
                            seats: seats,
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
                            height: _isAmberExpanded
                                ? size.height / 4.5
                                : size.height / 5,
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
